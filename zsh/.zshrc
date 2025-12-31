# Homebrew path detection - prioritize $HOME/homebrew (no sudo required)
if [[ -f "$HOME/homebrew/bin/brew" ]]; then
    eval "$("$HOME/homebrew/bin/brew" shellenv)"
elif [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
unsetopt correct_all

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="codehance"

ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# export EDITOR="code -w"
# export EDITOR="vim"
export EDITOR="cursor --wait"

# Example aliases
alias zshrc="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias tmuxconf="vim ~/.tmux.conf"
alias pip=pip3
# Keep all your existing aliases and functions below this line

# ===============================================
# Git aliases
# ===============================================

# Status
alias gs='git status'
# Example usage:
# gs

# Check out main
alias gcm='git checkout main'
# Example usage:
# gcm

# Stage changes
alias ga='git add .'
# Example usage:
# ga

# Git commit
alias gc='git commit -m'
# Example usage:
# gc "Your commit message"

# Push changes to the remote repository
alias gp='git push'
# Example usage:
# gp

# Pull changes from the remote repository
alias gpl='git pull'
# Example usage:
# gpl

# Switch to a different branch
alias gco='git checkout'
# Example usage:
# gco branch-name

# Create a new branch and switch to it
alias gcb='git checkout -b'
# Example usage:
# gcb new-branch-name

# Clone a remote repository
alias gcl='git clone'
# Example usage:
# gcl https://github.com/user/repository.git

# Merge a branch into the current branch
alias gm='git merge'
# Example usage:
# gm branch-to-merge

# Delete a local branch
alias gbd='git branch -d'
# Example usage:
# gbd branch-name

# Delete a remote branch
alias gbdr='git push origin --delete'
# Example usage:
# gbdr branch-name

# Fetch changes from the remote repository
alias gf='git fetch'
# Example usage:
# gf

# List all branches (local and remote)
alias gb='git branch -a'
# Example usage:
# gb

# Add all changes and commit with a message
alias gac='git add . && git commit -m'
# Example usage:
# gac "Your commit message"

# Create a GitHub pull request with the same title and body
alias gpr='gh pr create --base main --title "$1" --body "$1"'
# Example usage:
# gpr "PR title" "PR body"

# Function to switch to a branch and pull the latest changes
alias gcp='function _gcp(){ git checkout $1 && git pull };_gcp'

# Example usage:
# gcp branch-name

# Function to add all changes, commit with a message, and push
alias gacp='function _gacp(){ git add . && git commit -m "$1" && git push };_gacp'

# Example usage:
# gacp "Your commit message"

# Function to create a GitHub pull request with title and body derived from the branch name
alias gpr='function _gpr(){
    current_branch=$(git symbolic-ref --short HEAD);
    body=${1:-$current_branch}
    gh pr create --base main --title "$current_branch" --body "$body";
}; _gpr'

# Example usage:
# gpr "PR what you did" or gpr

# Function to push to origin and set upstream for the current branch
alias gpo='function _gpo(){ current_branch=$(git symbolic-ref --short HEAD); git push origin -u "$current_branch"; }; _gpo'
# Example usage:
# gpo

# Function to add commit and push origin all in one
alias gacpu='function _gacpu(){ current_branch=$(git symbolic-ref --short HEAD); git add . && git commit -m "$1" && git push origin -u "$current_branch"; }; _gacpu'
# Example usage:
# gacp "Your commit message"

# Function to pull from origin main into feature branch
alias gpm='function _gpm(){ current_branch=$(git symbolic-ref --short HEAD); git checkout main && git pull && git checkout "$current_branch" && git merge main; }; _gpm'
# Example usage:
# gpm

# Function to remove the current branch by checking out to main, then removing the branch and pulling from main
alias gbd='function _gbd(){
    current_branch=$(git symbolic-ref --short HEAD);
    name=${1:-$current_branch}
    git checkout main && git pull && git branch -d "$current_branch";
}; _gbd'
# Example usage:
# gbd branch-name or gbd (this deletes current branch)

# PostgreSQL aliases (update paths after installing postgresql)
alias pg-start='brew services start postgresql@14'
alias pg-stop='brew services stop postgresql@14'
alias pg-restart='brew services restart postgresql@14'
alias pg-status='brew services list | grep postgresql'

# Service management aliases
alias services='brew services list'

# More robust service management functions
alias stop-all='function _stopall(){
    echo "Stopping PostgreSQL..."
    brew services stop postgresql@14
    echo "Stopping Redis..."
    brew services stop redis
    echo "Stopping MongoDB..."
    brew services stop mongodb-community@6.0
    echo "Stopping Kibana..."
    brew services stop kibana-full
    echo "Stopping ElasticSearch..."
    echo "All services stopped. Current status:"
    brew services list
}; _stopall'

alias start-all='function _startall(){
    echo "Starting PostgreSQL..."
    brew services start postgresql@14
    echo "Starting Redis..."
    brew services start redis
    echo "Starting MongoDB..."
    brew services start mongodb-community@6.0
    echo "Starting Kibana..."
    brew services start kibana-full
    echo "Starting ElasticSearch..."
    echo "All services started. Current status:"
    brew services list
}; _startall'

alias restart-all='function _restartall(){
    echo "Restarting all services..."
    stop-all
    sleep 2
    start-all
}; _restartall'

# MongoDB aliases
alias mongo-start='brew services start mongodb-community@6.0'
alias mongo-stop='brew services stop mongodb-community@6.0'
alias mongo-restart='brew services restart mongodb-community@6.0'

# Redis aliases
alias redis-start='brew services start redis'
alias redis-stop='brew services stop redis'
alias redis-restart='brew services restart redis'

# Kibana aliases
alias kibana-start='brew services start kibana-full'
alias kibana-stop='brew services stop kibana-full'
alias kibana-restart='brew services restart kibana-full'

# Keep your existing PATH additions
export PATH="$PATH:$HOME/Library/Android/sdk/cmdline-tools/latest/bin"

# ElasticSearch configuration
export ES_HOME="/usr/local/elasticsearch"
export PATH="$ES_HOME/bin:$PATH"

# ElasticSearch aliases
alias es-start='elasticsearch -d -p /tmp/elasticsearch-pid'
alias es-stop='pkill -F /tmp/elasticsearch-pid'
alias es-status='curl -X GET "localhost:9200/_cat/health?v"'
alias es-log='tail -f $ES_HOME/logs/elasticsearch.log'

# Enhanced reset function for manual installation (using curl)
alias es-reset='function _esreset(){
    echo "Stopping ElasticSearch..."
    es-stop 2>/dev/null
    
    echo "Downloading ElasticSearch..."
    curl -L -o elasticsearch.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.11.1-darwin-aarch64.tar.gz
    
    echo "Extracting..."
    sudo rm -rf /usr/local/elasticsearch
    sudo mkdir -p /usr/local
    sudo tar -xzf elasticsearch.tar.gz -C /usr/local
    sudo mv /usr/local/elasticsearch-8.11.1 /usr/local/elasticsearch
    
    echo "Setting permissions..."
    sudo chown -R $(whoami):staff /usr/local/elasticsearch
    
    echo "Cleaning up..."
    rm elasticsearch.tar.gz
    
    echo "Creating configuration..."
    mkdir -p /usr/local/elasticsearch/config
    cat << EOF > /usr/local/elasticsearch/config/elasticsearch.yml
cluster.name: elasticsearch_local
node.name: elasticsearch_node1
path.data: /usr/local/elasticsearch/data
path.logs: /usr/local/elasticsearch/logs
network.host: 127.0.0.1
http.port: 9200
discovery.type: single-node
xpack.security.enabled: false
EOF
    
    echo "Starting ElasticSearch..."
    es-start
    
    echo "Waiting for service to start..."
    sleep 15
    
    echo "Service status:"
    es-status
    
    echo "\nTrying to connect to ElasticSearch..."
    curl -X GET "http://localhost:9200"
}; _esreset'

# ElasticSearch management aliases
alias es-indices='curl -X GET "localhost:9200/_cat/indices?v"'
alias es-health='curl -X GET "localhost:9200/_cluster/health?pretty"'
alias es-nodes='curl -X GET "localhost:9200/_cat/nodes?v"'
alias es-settings='curl -X GET "localhost:9200/_cluster/settings?pretty"'

# Function to delete an index
alias es-delete-index='function _esdeleteindex(){ curl -X DELETE "localhost:9200/$1"; }; _esdeleteindex'

# Function to create an index
alias es-create-index='function _escreateindex(){ curl -X PUT "localhost:9200/$1"; }; _escreateindex'

alias phonecast='~/phonecast.sh'
alias python=python3

# Docker aliases
dc-up() {
    if [ $# -eq 0 ]; then
        docker-compose up -d
    else
        docker-compose up -d "$1"
    fi
}

dc-down() {
    if [ $# -eq 0 ]; then
        docker-compose down
    else
        docker-compose stop "$1"
    fi
}

dc-restart() {
    if [ $# -eq 0 ]; then
        docker-compose restart
    else
        docker-compose restart "$1"
    fi
}

dc-rebuild() {
    if [ $# -eq 0 ]; then
        docker-compose up --build -d
    else
        docker-compose up --build -d "$1"
    fi
}

dc-logs() {
    if [ $# -eq 0 ]; then
        docker-compose logs -f
    else
        docker-compose logs -f "$1"
    fi
}

dc-stop() {
    if [ $# -eq 0 ]; then
        docker-compose stop
    else
        docker-compose stop "$1"
    fi
}

dc-start() {
    if [ $# -eq 0 ]; then
        docker-compose start
    else
        docker-compose start "$1"
    fi
}

# Keep dc-ps as alias since it doesn't need service targeting
alias dc-ps='docker-compose ps'

dc-clean() {
    case "$1" in
        "orphans"|"")
            docker-compose down --remove-orphans
            ;;
        "volumes")
            docker-compose down --remove-orphans --volumes
            ;;
        "all")
            docker-compose down --remove-orphans --volumes --rmi all
            ;;
        "local")
            docker-compose down --remove-orphans --rmi local
            ;;
        *)
            echo "Usage: dc-clean [orphans|volumes|all|local]"
            echo "  orphans (default): Remove orphan containers"
            echo "  volumes: Remove orphans + volumes"
            echo "  all: Remove orphans + volumes + all images"
            echo "  local: Remove orphans + local images only"
            ;;
    esac
}

dc-help() {
    echo "🐳 Docker Compose Commands Help"
    echo "================================"
    echo ""
    echo "📋 Basic Commands:"
    echo "  dc-up [service]     - Start services (all or specific)"
    echo "  dc-down [service]   - Stop services (all or specific)"
    echo "  dc-restart [service]- Restart services (all or specific)"
    echo "  dc-rebuild [service]- Rebuild and start services (all or specific)"
    echo "  dc-start [service]  - Start stopped services (all or specific)"
    echo "  dc-stop [service]   - Stop running services (all or specific)"
    echo ""
    echo "📊 Monitoring Commands:"
    echo "  dc-logs [service]   - Show logs (all or specific service)"
    echo "  dc-ps               - Show running containers"
    echo ""
    echo "🧹 Cleanup Commands:"
    echo "  dc-clean orphans   - Remove orphan containers (default)"
    echo "  dc-clean volumes   - Remove orphans + volumes"
    echo "  dc-clean all       - Remove orphans + volumes + all images"
    echo "  dc-clean local     - Remove orphans + local images only"
    echo ""
    echo "💡 Usage Examples:"
    echo "  dc-up                    # Start all services"
    echo "  dc-up auth               # Start only auth service"
    echo "  dc-rebuild graphql-gateway # Rebuild only graphql-gateway"
    echo "  dc-logs auth             # Show auth service logs"
    echo "  dc-restart               # Restart all services"
    echo "  dc-stop dashboard        # Stop only dashboard service"
    echo ""
    echo "🔍 Quick Status Check:"
    echo "  dc-ps                    # See what's running"
    echo ""
    echo "📝 Notes:"
    echo "  - All commands work with all services if no service name provided"
    echo "  - Service names: auth, dashboard, authdb"
    echo "  - Use 'dc-ps' to see current running services"
}

# Function to create and activate Python virtual environment
mkvenv() {
    local venv_name=${1:-venv}  # Use provided name or default to 'venv'
    python3 -m venv $venv_name
    source $venv_name/bin/activate
    echo "✅ Virtual environment '$venv_name' created and activated!"
}

# Supabase function that handles -h flag and auto-adds env file for functions serve
sbase() {
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        echo "🚀 Supabase CLI Commands Help"
        echo "=============================="
        echo ""
        echo "🏃 Local Development:"
        echo "  sbase start              - Start local Supabase instance"
        echo "  sbase stop               - Stop local Supabase instance"
        echo "  sbase status             - Check status of local Supabase"
        echo "  sbase restart            - Restart local Supabase"
        echo ""
        echo "🗄️  Database Management:"
        echo "  sbase db reset           - Reset local database (drops all data)"
        echo "  sbase db push            - Push migrations to remote database"
        echo "  sbase db pull            - Pull schema from remote database"
        echo "  sbase db diff            - Show database schema differences"
        echo "  sbase db remote commit  - Commit remote database changes"
        echo ""
        echo "📝 Migrations:"
        echo "  sbase migration new <name> - Create a new migration file"
        echo "  sbase migration list      - List all migrations"
        echo "  sbase migration repair    - Repair migration history"
        echo ""
        echo "⚡ Edge Functions:"
        echo "  sbase functions new <name> - Create a new edge function"
        echo "  sbase functions serve [name] - Serve edge functions locally (auto-loads .env)"
        echo "  sbase functions deploy [name] - Deploy edge function to remote"
        echo "  sbase functions list          - List all edge functions"
        echo "  sbase functions delete <name>  - Delete an edge function"
        echo ""
        echo "🔗 Project Management:"
        echo "  sbase link [project-ref]     - Link to remote Supabase project"
        echo "  sbase unlink                 - Unlink from remote project"
        echo "  sbase projects list          - List all your Supabase projects"
        echo "  sbase projects create <name> - Create a new project"
        echo ""
        echo "📦 Type Generation:"
        echo "  sbase gen types typescript  - Generate TypeScript types from schema"
        echo "  sbase gen types typescript --local - Generate from local database"
        echo ""
        echo "🔐 Auth & Secrets:"
        echo "  sbase secrets list           - List project secrets"
        echo "  sbase secrets set <name>      - Set a secret"
        echo "  sbase secrets unset <name>   - Remove a secret"
        echo ""
        echo "📊 Other Commands:"
        echo "  sbase storage list           - List storage buckets"
        echo "  sbase storage create <name>  - Create a storage bucket"
        echo "  sbase logs                    - View project logs"
        echo "  sbase inspect db             - Inspect database schema"
        echo ""
        echo "💡 Quick Start:"
        echo "  sbase start                  # Start local Supabase"
        echo "  sbase status                  # Check what's running"
        echo "  sbase migration new <name>    # Create new migration"
        echo "  sbase gen types typescript --local  # Generate types"
        echo ""
        echo "📚 Documentation: https://supabase.com/docs/reference/cli"
    elif [[ "$1" == "functions" ]] && [[ "$2" == "serve" ]]; then
        # Auto-add --env-file flag for functions serve
        shift 2  # Remove "functions" and "serve" from arguments
        command supabase functions serve --env-file supabase/.env "$@"
    else
        command supabase "$@"
    fi
}

export PATH="$HOME/bin:$PATH"

# Vim -> Neovim
alias vim='nvim'
alias vi='nvim'

# Tmux Aliases
# Add these to your ~/.bashrc or ~/.zshrc

# Session management
alias tmn='tmux new -s'           # tmn myproject
alias tma='tmux attach -t'        # tma myproject
alias tml='tmux ls'               # list sessions
alias tmk='tmux kill-session -t'  # tmk myproject
alias tmka='tmux kill-server'     # kill all sessions

# Quick attach or create
tm() {
  if [ -n "$1" ]; then
    tmux attach -t "$1" 2>/dev/null || tmux new -s "$1"
  else
    tmux attach 2>/dev/null || tmux new -s main
  fi
}
# Usage: tm           → attach to last session or create "main"
#        tm myproject → attach to "myproject" or create it

# Window management (from outside tmux)
alias tmw='tmux new-window'
alias tmwl='tmux list-windows'

# Quick dev setup: creates 3 windows (editor, server, terminal)
tmdev() {
  session=${1:-dev}
  tmux new-session -d -s "$session" -n editor
  tmux new-window -t "$session" -n server
  tmux new-window -t "$session" -n terminal
  tmux select-window -t "$session":0
  tmux attach -t "$session"
}
# Usage: tmdev           → creates "dev" session with 3 windows
#        tmdev myproject → creates "myproject" session with 3 windows

# Cheatsheet
alias tmux-help='echo "
Tmux Aliases:
  tm [name]    - attach or create session
  tmn name     - new session
  tma name     - attach to session
  tml          - list sessions
  tmk name     - kill session
  tmka         - kill all sessions
  tmdev [name] - create dev setup (3 windows)

Inside tmux (Ctrl+A prefix):
  c   new window      n/p  next/prev window
  0-9 go to window    ,    rename window
  &   kill window     d    detach
  \"   h-split         %    v-split
  z   zoom pane       x    kill pane
"'

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"
