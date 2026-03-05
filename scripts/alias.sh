#!/bin/bash

# Remote install: curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/alias.sh | bash

# Define aliases
declare -A ALIASES=(
    # Docker
    ["dps"]="docker ps -a --size --format \"table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Size}}\""
    ["di"]="docker images"
    ["dex"]="docker exec -it"
    ["dlog"]="docker logs -f"
    ["dstop"]="docker stop \$(docker ps -aq)"
    ["drm"]="docker rm \$(docker ps -aq)"
    ["dri"]="docker rmi \$(docker images -q)"
    ["dprune"]="docker system prune -af"

    # Docker Compose
    ["dcu"]="docker compose up -d"
    ["dcd"]="docker compose down"
    ["dcl"]="docker compose logs -f"
    ["dcr"]="docker compose restart"

    # Git
    ["gs"]="git status"
    ["ga"]="git add"
    ["gaa"]="git add ."
    ["gc"]="git commit -m"
    ["gp"]="git push"
    ["gpl"]="git pull"
    ["gco"]="git checkout"
    ["gb"]="git branch"
    ["gd"]="git diff"
    ["glog"]="git log --oneline --graph --decorate -10"

    # General
    ["cls"]="clear"
    ["ll"]="ls -la"
    ["la"]="ls -A"
    [".."]="cd .."
    ["..."]="cd ../.."
    ["myip"]="curl -s ipecho.net/plain; echo"
    ["ports"]="netstat -tulanp"
    ["h"]="history"
)

BASHRC="$HOME/.bashrc"

# Ensure .bashrc exists
touch "$BASHRC"

echo "Installing aliases..."
echo ""

added=0
skipped=0

for alias_name in "${!ALIASES[@]}"; do
    alias_cmd="${ALIASES[$alias_name]}"
    alias_line="alias $alias_name='$alias_cmd'"

    # Check if alias already exists
    if grep -q "^alias $alias_name=" "$BASHRC"; then
        echo "  [skip] $alias_name"
        ((skipped++))
    else
        echo "$alias_line" >> "$BASHRC"
        echo "  [add]  $alias_name"
        ((added++))
    fi
done

echo ""
echo "================================"
echo "  Added: $added | Skipped: $skipped"
echo "================================"
echo ""
echo "Run 'source ~/.bashrc' or restart terminal to apply"
