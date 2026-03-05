#!/bin/bash

# ============================================
#  ExpTech Bash Aliases Installer
#  Version: 1.0.1 (2025-03-06)
#
#  Install:
#    curl -fsSL https://raw.githubusercontent.com/ExpTechTW/API/refs/heads/main/scripts/alias.sh | bash
# ============================================

VERSION="1.0.1 (2025-03-06)"
BASHRC="$HOME/.bashrc"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================
#  Aliases
# ============================================
declare -A ALIASES=(
    # Docker
    ["di"]="docker images"
    ["dex"]="docker exec -it"
    ["dlog"]="docker logs -f"
    ["dstart"]="docker start"
    ["dstop"]="docker stop"
    ["drestart"]="docker restart"
    ["drm"]="docker rm"
    ["drmi"]="docker rmi"
    ["dprune"]="docker system prune -af"
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

    # Git
    ["gs"]="git status"
    ["ga"]="git add"
    ["gaa"]="git add ."
    ["gc"]="git commit -m"
    ["gca"]="git commit --amend"
    ["gp"]="git push"
    ["gpf"]="git push --force-with-lease"
    ["gpl"]="git pull"
    ["gf"]="git fetch"
    ["gb"]="git branch"
    ["gba"]="git branch -a"
    ["gbd"]="git branch -d"
    ["gco"]="git checkout"
    ["gcb"]="git checkout -b"
    ["gm"]="git merge"
    ["gd"]="git diff"
    ["gds"]="git diff --staged"
    ["glog"]="git log --oneline --graph --decorate -15"
    ["gloga"]="git log --oneline --graph --decorate --all -15"
    ["gst"]="git stash"
    ["gstp"]="git stash pop"
    ["gstl"]="git stash list"
    ["grh"]="git reset HEAD"
    ["grhh"]="git reset HEAD --hard"

    # Navigation
    ["cls"]="clear"
    [".."]="cd .."
    ["..."]="cd ../.."
    ["...."]="cd ../../.."

    # List
    ["ll"]="ls -lah"
    ["la"]="ls -A"
    ["l"]="ls -CF"

    # Utils
    ["h"]="history"
    ["hg"]="history | grep"
    ["myip"]="curl -s ipecho.net/plain; echo"
    ["ports"]="netstat -tulanp"
    ["df"]="df -h"
    ["free"]="free -h"
    ["now"]="date +%Y-%m-%d_%H:%M:%S"
    ["week"]="date +%V"
)

# ============================================
#  Functions (special characters)
# ============================================
FUNCTIONS=(
'dps() { docker ps -a --size --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Size}}"; }'
'dip() { docker inspect --format "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" "$@"; }'
'dstopall() { docker stop $(docker ps -aq); }'
'drmall() { docker rm $(docker ps -aq); }'
'drmiall() { docker rmi $(docker images -q); }'
'localip() { hostname -I | awk "{print \$1}"; }'
'psg() { ps aux | grep "$1"; }'
'path() { echo $PATH | tr ":" "\n"; }'
)

# ============================================
#  Completions
# ============================================
COMPLETIONS=(
    "complete -F _docker_container_logs dlog"
    "complete -F _docker_container_exec dex"
    "complete -F _docker_container_start dstart"
    "complete -F _docker_container_stop dstop"
    "complete -F _docker_container_restart drestart"
    "complete -F _docker_container_rm drm"
    "complete -F _docker_inspect dip"
    "complete -F _docker_image_rm drmi"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gco"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gcb"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gb"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gbd"
    "complete -o bashdefault -o default -o nospace -F __git_wrap__git_main gm"
)

# ============================================
#  Install
# ============================================
echo -e "${BLUE}"
echo "  ╔═══════════════════════════════════════╗"
echo "  ║   ExpTech Bash Aliases Installer      ║"
echo "  ║   Version: ${VERSION}           ║"
echo "  ╚═══════════════════════════════════════╝"
echo -e "${NC}"

touch "$BASHRC"

# Backup
if [[ ! -f "$BASHRC.bak" ]]; then
    cp "$BASHRC" "$BASHRC.bak"
    echo -e "${GREEN}[backup]${NC} ~/.bashrc.bak"
fi

# Install aliases
echo -e "\n${BLUE}[Aliases]${NC}"
added=0; skipped=0; updated=0

for name in "${!ALIASES[@]}"; do
    cmd="${ALIASES[$name]}"
    line="alias $name='$cmd'"

    if grep -q "^alias $name=" "$BASHRC"; then
        existing=$(grep "^alias $name=" "$BASHRC")
        if [[ "$existing" != "$line" ]]; then
            sed -i "/^alias $name=/d" "$BASHRC"
            echo "$line" >> "$BASHRC"
            echo -e "  ${YELLOW}[update]${NC} $name"
            ((updated++))
        else
            ((skipped++))
        fi
    else
        echo "$line" >> "$BASHRC"
        echo -e "  ${GREEN}[add]${NC}    $name"
        ((added++))
    fi
done

# Install functions
echo -e "\n${BLUE}[Functions]${NC}"
for func in "${FUNCTIONS[@]}"; do
    name=$(echo "$func" | cut -d'(' -f1)
    if grep -q "^${name}()" "$BASHRC"; then
        sed -i "/^${name}()/d" "$BASHRC"
    fi
    echo "$func" >> "$BASHRC"
    echo -e "  ${GREEN}[add]${NC}    $name"
done

# Install completions
echo -e "\n${BLUE}[Completions]${NC}"
comp_added=0
for comp in "${COMPLETIONS[@]}"; do
    if ! grep -qF "$comp" "$BASHRC"; then
        echo "$comp" >> "$BASHRC"
        ((comp_added++))
    fi
done
echo -e "  ${GREEN}[done]${NC}   $comp_added added"

# Summary
echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "  ${GREEN}Added:${NC} $added  ${YELLOW}Updated:${NC} $updated  ${BLUE}Skipped:${NC} $skipped"
echo -e "${BLUE}════════════════════════════════════════${NC}"

echo -e "
${YELLOW}╔═══════════════════════════════════════╗
║  ${GREEN}source ~/.bashrc${YELLOW}                     ║
╚═══════════════════════════════════════╝${NC}
"
