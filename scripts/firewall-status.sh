#!/bin/bash
# firewall-status.sh - 防火牆 vs 實際端口 對比檢查
# curl -fsSL https://raw.githubusercontent.com/ExpTechTW/API/refs/heads/main/scripts/firewall-status.sh | sudo bash

set -e

HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')
UPTIME=$(uptime -p)
KERNEL=$(uname -r)

echo "======================================"
echo "  Firewall Check - $HOSTNAME"
echo "======================================"
echo "  IP:     $IP"
echo "  Kernel: $KERNEL"
echo "  Uptime: $UPTIME"
echo "  Date:   $(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================"

# nftables status
NFT_STATUS=$(systemctl is-active nftables 2>/dev/null || echo "inactive")
NFT_ENABLED=$(systemctl is-enabled nftables 2>/dev/null || echo "disabled")
echo ""
echo "[nftables] status: $NFT_STATUS | boot: $NFT_ENABLED"

# trusted servers
TRUSTED=$(nft list ruleset 2>/dev/null | grep -oP 'saddr \{ [^}]+\}' | head -1 | grep -oP '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort -u)
if [ -n "$TRUSTED" ]; then
    echo ""
    echo "[Trusted Servers]"
    echo "$TRUSTED" | while read -r ip; do
        printf "  - %s\n" "$ip"
    done
fi

# parse firewall rules
PUBLIC_RULES=$(nft list ruleset 2>/dev/null | grep "dport" | grep -v "saddr" || true)
PRIVATE_RULES=$(nft list ruleset 2>/dev/null | grep "dport" | grep "saddr" || true)

get_ports() {
    echo "$1" | grep -oP "dport \K[0-9]+"
    echo "$1" | grep -oP "dport \{ [^}]+ \}" | grep -oP "[0-9]+"
}

PUBLIC_PORTS=$(get_ports "$PUBLIC_RULES" | sort -un)
PRIVATE_PORTS=$(get_ports "$PRIVATE_RULES" | sort -un)
FW_ALL=$(echo -e "$PUBLIC_PORTS\n$PRIVATE_PORTS" | grep -v '^$' | sort -un)

# parse listening ports with process info
declare -A PORT_PROCESS
while IFS= read -r line; do
    port=$(echo "$line" | awk '{split($5,a,":"); print a[length(a)]}')
    proc=$(echo "$line" | grep -oP 'users:\(\("\K[^"]+' || echo "unknown")
    addr=$(echo "$line" | awk '{print $5}')
    if [[ "$addr" == 127.0.0.* ]] || [[ "$addr" == "::1:"* ]] || [[ "$addr" == *"%lo:"* ]]; then
        continue
    fi
    PORT_PROCESS[$port]="$proc"
done < <(ss -tulnp | tail -n +2)

LISTEN_PORTS=$(printf '%s\n' "${!PORT_PROCESS[@]}" | sort -un)

# output
ALL_PORTS=$(echo -e "$FW_ALL\n$LISTEN_PORTS" | grep -v '^$' | sort -un)

echo ""
printf "%-8s %-18s %-10s %-10s %-10s %s\n" "PORT" "PROCESS" "LISTEN" "FIREWALL" "ACCESS" "STATUS"
printf "%-8s %-18s %-10s %-10s %-10s %s\n" "----" "-------" "------" "--------" "------" "------"

OK=0
WARN=0

for port in $ALL_PORTS; do
    listen="--"
    fw="--"
    access="--"
    status=""
    proc="--"

    if echo "$LISTEN_PORTS" | grep -qx "$port"; then
        listen="YES"
        proc="${PORT_PROCESS[$port]:-unknown}"
    fi
    if echo "$FW_ALL" | grep -qx "$port"; then fw="YES"; fi

    if echo "$PUBLIC_PORTS" | grep -qx "$port"; then
        access="PUBLIC"
    elif echo "$PRIVATE_PORTS" | grep -qx "$port"; then
        access="PRIVATE"
    fi

    if [ "$listen" = "YES" ] && [ "$fw" = "--" ]; then
        access="BLOCKED"
        status="!! listening but no rule"
        WARN=$((WARN+1))
    elif [ "$listen" = "--" ] && [ "$fw" = "YES" ]; then
        status="!! rule but not listening"
        WARN=$((WARN+1))
    else
        status="OK"
        OK=$((OK+1))
    fi

    printf "%-8s %-18s %-10s %-10s %-10s %s\n" "$port" "$proc" "$listen" "$fw" "$access" "$status"
done

# summary
TOTAL=$((OK+WARN))
echo ""
echo "======================================"
echo "  Total: $TOTAL | OK: $OK | Warnings: $WARN"
echo "======================================"

if [ "$WARN" -gt 0 ]; then
    exit 1
fi
