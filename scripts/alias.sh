#!/bin/bash

# ============================================
#  ExpTech Bash Aliases Installer
#  Version: 1.0.0
#  Date: 2025-03-06
#  Remote install:
#    curl -fsSL https://raw.githubusercontent.com/ExpTechTW/API/refs/heads/main/scripts/alias.sh | bash
# ============================================

VERSION="1.0.0 (2025-03-06)"
BASHRC="$HOME/.bashrc"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ============================================
#  Aliases Definition
# ============================================
declare -A ALIASES=(
    # Docker - Container
    ["dps"]="docker ps -a --size --format \"table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Size}}\""
    ["di"]="docker images"
    ["dex"]="docker exec -it"
    ["dlog"]="docker logs -f"
    ["dstart"]="docker start"
    ["dstop"]="docker stop"
    ["drestart"]="docker restart"
    ["dstopall"]="docker stop \$(docker ps -aq)"
    ["drm"]="docker rm"
    ["drmall"]="docker rm \$(docker ps -aq)"
    ["drmi"]="docker rmi"
    ["drmiall"]="docker rmi \$(docker images -q)"
    ["dprune"]="docker system prune -af"
    ["dip"]="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
    ["dtop"]="docker stats --no-stream"

    # Docker Compose
    ["dc"]="docker compose"
    ["dcu"]="docker compose up -d"
    ["dcd"]="docker compose down"
    ["dcl"]="docker compose logs -f"
    ["dcr"]="docker compose restart"
    ["dcb"]="docker compose build"
    ["dcp"]="docker compose pull"
    ["dcps"]="docker compose ps"

    # Git - Basic
    ["gs"]="git status"
    ["ga"]="git add"
    ["gaa"]="git add ."
    ["gc"]="git commit -m"
    ["gca"]="git commit --amend"
    ["gp"]="git push"
    ["gpf"]="git push --force-with-lease"
    ["gpl"]="git pull"
    ["gf"]="git fetch"

    # Git - Branch
    ["gb"]="git branch"
    ["gba"]="git branch -a"
    ["gbd"]="git branch -d"
    ["gco"]="git checkout"
    ["gcb"]="git checkout -b"
    ["gm"]="git merge"

    # Git - Diff & Log
    ["gd"]="git diff"
    ["gds"]="git diff --staged"
    ["glog"]="git log --oneline --graph --decorate -15"
    ["gloga"]="git log --oneline --graph --decorate --all -15"

    # Git - Stash
    ["gst"]="git stash"
    ["gstp"]="git stash pop"
    ["gstl"]="git stash list"

    # Git - Reset
    ["grh"]="git reset HEAD"
    ["grhh"]="git reset HEAD --hard"

    # General - Navigation
    ["cls"]="clear"
    [".."]="cd .."
    ["..."]="cd ../.."
    ["...."]="cd ../../.."

    # General - List
    ["ll"]="ls -lah"
    ["la"]="ls -A"
    ["l"]="ls -CF"

    # General - Safety
    ["cp"]="cp -i"
    ["mv"]="mv -i"
    ["rm"]="rm -i"

    # General - Utils
    ["h"]="history"
    ["hg"]="history | grep"
    ["myip"]="curl -s ipecho.net/plain; echo"
    ["localip"]="hostname -I | awk '{print \$1}'"
    ["ports"]="netstat -tulanp"
    ["df"]="df -h"
    ["du"]="du -h"
    ["free"]="free -h"
    ["psg"]="ps aux | grep"

    # General - Misc
    ["now"]="date '+%Y-%m-%d %H:%M:%S'"
    ["week"]="date +%V"
    ["path"]="echo \$PATH | tr ':' '\n'"
)

# ============================================
#  Completions Definition
# ============================================
COMPLETIONS=(
    # Docker container completions
    "complete -F _docker_container_logs dlog"
    "complete -F _docker_container_exec dex"
    "complete -F _docker_container_start dstart"
    "complete -F _docker_container_stop dstop"
    "complete -F _docker_container_restart drestart"
    "complete -F _docker_container_rm drm"
    "complete -F _docker_inspect dip"
    # Docker image completions
    "complete -F _docker_image_rm drmi"
    # Git completions
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gco"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gcb"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gb"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gbd"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gm"
)

# ============================================
#  Main Installation
# ============================================

echo -e "${BLUE}"
echo "  ╔═══════════════════════════════════════╗"
echo "  ║   ExpTech Bash Aliases Installer      ║"
echo "  ║   Version: $VERSION            ║"
echo "  ╚═══════════════════════════════════════╝"
echo -e "${NC}"

# Ensure .bashrc exists
touch "$BASHRC"

# Backup .bashrc
if [[ ! -f "$BASHRC.bak" ]]; then
    cp "$BASHRC" "$BASHRC.bak"
    echo -e "${GREEN}[backup]${NC} Created ~/.bashrc.bak"
fi

echo ""
echo "Installing aliases..."
echo ""

added=0
skipped=0
updated=0

for alias_name in "${!ALIASES[@]}"; do
    alias_cmd="${ALIASES[$alias_name]}"
    alias_line="alias $alias_name='$alias_cmd'"

    if grep -q "^alias $alias_name=" "$BASHRC"; then
        # Check if alias value is the same
        existing=$(grep "^alias $alias_name=" "$BASHRC")
        if [[ "$existing" != "$alias_line" ]]; then
            # Update existing alias
            sed -i "s|^alias $alias_name=.*|$alias_line|" "$BASHRC"
            echo -e "  ${YELLOW}[update]${NC} $alias_name"
            ((updated++))
        else
            echo -e "  ${BLUE}[skip]${NC}   $alias_name"
            ((skipped++))
        fi
    else
        echo "$alias_line" >> "$BASHRC"
        echo -e "  ${GREEN}[add]${NC}    $alias_name"
        ((added++))
    fi
done

# Add completions
echo ""
echo "Installing completions..."
comp_added=0

for comp_line in "${COMPLETIONS[@]}"; do
    if ! grep -qF "$comp_line" "$BASHRC"; then
        echo "$comp_line" >> "$BASHRC"
        ((comp_added++))
    fi
done

echo -e "  ${GREEN}[done]${NC}   $comp_added completions added"

echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "  ${GREEN}Added:${NC}   $added"
echo -e "  ${YELLOW}Updated:${NC} $updated"
echo -e "  ${BLUE}Skipped:${NC} $skipped"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""

# Auto reload bashrc
source "$BASHRC" 2>/dev/null

echo -e "${GREEN}Aliases are now active!${NC}"
echo ""
