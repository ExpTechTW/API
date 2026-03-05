#!/bin/bash

# ============================================
#  ExpTech Bash Aliases Installer
#  Version: 1.1.1 (2025-03-06)
#
#  Install:
#    curl -fsSL https://raw.githubusercontent.com/ExpTechTW/API/refs/heads/main/scripts/alias.sh | bash
# ============================================

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
#  Completions (use native completion)
# ============================================
COMPLETION_SCRIPT='
# ExpTech Alias Completions

# Docker container name completion
_exptech_docker_containers() {
    local containers
    containers=$(docker ps -a --format "{{.Names}}" 2>/dev/null)
    COMPREPLY=($(compgen -W "$containers" -- "${COMP_WORDS[COMP_CWORD]}"))
}

# Docker image name completion
_exptech_docker_images() {
    local images
    images=$(docker images --format "{{.Repository}}:{{.Tag}}" 2>/dev/null | grep -v "<none>")
    COMPREPLY=($(compgen -W "$images" -- "${COMP_WORDS[COMP_CWORD]}"))
}

# Git branch completion
_exptech_git_branches() {
    local branches
    branches=$(git branch -a 2>/dev/null | sed "s/^[* ]*//" | sed "s/remotes\///" | sort -u)
    COMPREPLY=($(compgen -W "$branches" -- "${COMP_WORDS[COMP_CWORD]}"))
}

# Apply Docker completions
complete -F _exptech_docker_containers dlog dex dstart dstop drestart drm dip
complete -F _exptech_docker_images drmi

# Apply Git completions
complete -F _exptech_git_branches gco gcb gbd gm
'

# ============================================
#  Install
# ============================================
echo -e "${BLUE}"
echo "  ╔════════════════════════════════════╗"
echo "  ║  ExpTech Bash Aliases Installer    ║"
echo "  ║       v1.1.1 (2025-03-06)          ║"
echo "  ╚════════════════════════════════════╝"
echo -e "${NC}"

touch "$BASHRC"

# Fix Windows line endings
sed -i 's/\r$//' "$BASHRC"

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

    if grep -q "^alias ${name}=" "$BASHRC"; then
        ((skipped++))
    else
        printf '%s\n' "$line" >> "$BASHRC"
        echo -e "  ${GREEN}[add]${NC}    $name"
        ((added++))
    fi
done

# Install functions
echo -e "\n${BLUE}[Functions]${NC}"
echo "" >> "$BASHRC"  # Add blank line before functions
for func in "${FUNCTIONS[@]}"; do
    name=$(echo "$func" | cut -d'(' -f1)
    printf '%s\n' "$func" >> "$BASHRC"
    echo -e "  ${GREEN}[add]${NC}    $name"
done

# Install completions
echo -e "\n${BLUE}[Completions]${NC}"
if ! grep -q "_exptech_docker_containers" "$BASHRC"; then
    printf '%s\n' "$COMPLETION_SCRIPT" >> "$BASHRC"
    echo -e "  ${GREEN}[add]${NC}    docker & git completions"
else
    echo -e "  ${BLUE}[skip]${NC}   already installed"
fi

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
