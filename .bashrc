#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- Exports ---
export TZ=America/Sao_Paulo

# Fix locale error
export LANG=pt_BR

# Add vim as editor
export EDITOR=/usr/bin/nvim

# Add local binaries to path
export PATH=$HOME/.local/bin:$PATH
export MONGODB_URI="mongodb://localhost:27017/"

# Export Projects folder
export PROJECTS="/home/fellipe/Projects"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# GoLang to PATH
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

# Export yarn global bins
export PATH="$PATH:$(yarn global bin)"

# --- Exports End ---

# --- Aliases ---

alias nvim_config='cd $HOME/.config/nvim; nvim .'
alias get_esprs='. $HOME/.export-esp.sh'
alias size='du -hs'
alias waybar-reset='killall -SIGUSR2 waybar'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pacman='sudo pacman'
alias zephyr-docker='docker run --rm -ti \
  -v "$PWD":/workdir \
  --device=/dev/ttyUSB0:/dev/ttyUSB0 \
  --group-add $(stat -c "%g" /dev/ttyUSB0) \
  docker.io/zephyrprojectrtos/zephyr-build:main'

PS1='[\u@\h \W]\$ '
TMP='/tmp'

# --- Aliases End ---

# --- Bind ---

bind '"\C-t": reverse-search-history'
bind -r "\C-l"

# --- Bind End ---
. "$HOME/.cargo/env"

_diesel() {
  local i cur prev opts cmd
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  cmd=""
  opts=""

  for i in ${COMP_WORDS[@]}; do
    case "${cmd},${i}" in
    ",$1")
      cmd="diesel"
      ;;
    diesel,completions)
      cmd="diesel__completions"
      ;;
    diesel,database)
      cmd="diesel__database"
      ;;
    diesel,help)
      cmd="diesel__help"
      ;;
    diesel,migration)
      cmd="diesel__migration"
      ;;
    diesel,print-schema)
      cmd="diesel__print__schema"
      ;;
    diesel,setup)
      cmd="diesel__setup"
      ;;
    diesel__database,drop)
      cmd="diesel__database__drop"
      ;;
    diesel__database,help)
      cmd="diesel__database__help"
      ;;
    diesel__database,reset)
      cmd="diesel__database__reset"
      ;;
    diesel__database,setup)
      cmd="diesel__database__setup"
      ;;
    diesel__database__help,drop)
      cmd="diesel__database__help__drop"
      ;;
    diesel__database__help,help)
      cmd="diesel__database__help__help"
      ;;
    diesel__database__help,reset)
      cmd="diesel__database__help__reset"
      ;;
    diesel__database__help,setup)
      cmd="diesel__database__help__setup"
      ;;
    diesel__help,completions)
      cmd="diesel__help__completions"
      ;;
    diesel__help,database)
      cmd="diesel__help__database"
      ;;
    diesel__help,help)
      cmd="diesel__help__help"
      ;;
    diesel__help,migration)
      cmd="diesel__help__migration"
      ;;
    diesel__help,print-schema)
      cmd="diesel__help__print__schema"
      ;;
    diesel__help,setup)
      cmd="diesel__help__setup"
      ;;
    diesel__help__database,drop)
      cmd="diesel__help__database__drop"
      ;;
    diesel__help__database,reset)
      cmd="diesel__help__database__reset"
      ;;
    diesel__help__database,setup)
      cmd="diesel__help__database__setup"
      ;;
    diesel__help__migration,generate)
      cmd="diesel__help__migration__generate"
      ;;
    diesel__help__migration,list)
      cmd="diesel__help__migration__list"
      ;;
    diesel__help__migration,pending)
      cmd="diesel__help__migration__pending"
      ;;
    diesel__help__migration,redo)
      cmd="diesel__help__migration__redo"
      ;;
    diesel__help__migration,revert)
      cmd="diesel__help__migration__revert"
      ;;
    diesel__help__migration,run)
      cmd="diesel__help__migration__run"
      ;;
    diesel__migration,generate)
      cmd="diesel__migration__generate"
      ;;
    diesel__migration,help)
      cmd="diesel__migration__help"
      ;;
    diesel__migration,list)
      cmd="diesel__migration__list"
      ;;
    diesel__migration,pending)
      cmd="diesel__migration__pending"
      ;;
    diesel__migration,redo)
      cmd="diesel__migration__redo"
      ;;
    diesel__migration,revert)
      cmd="diesel__migration__revert"
      ;;
    diesel__migration,run)
      cmd="diesel__migration__run"
      ;;
    diesel__migration__help,generate)
      cmd="diesel__migration__help__generate"
      ;;
    diesel__migration__help,help)
      cmd="diesel__migration__help__help"
      ;;
    diesel__migration__help,list)
      cmd="diesel__migration__help__list"
      ;;
    diesel__migration__help,pending)
      cmd="diesel__migration__help__pending"
      ;;
    diesel__migration__help,redo)
      cmd="diesel__migration__help__redo"
      ;;
    diesel__migration__help,revert)
      cmd="diesel__migration__help__revert"
      ;;
    diesel__migration__help,run)
      cmd="diesel__migration__help__run"
      ;;
    *) ;;
    esac
  done

  case "${cmd}" in
  diesel)
    opts="-h -V --database-url --config-file --locked-schema --help --version migration setup database completions print-schema help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__completions)
    opts="-h --database-url --config-file --locked-schema --help bash elvish fish powershell zsh"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help setup reset drop help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database__drop)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database__help)
    opts="setup reset drop help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database__help__drop)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database__help__reset)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database__help__setup)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database__reset)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__database__setup)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help)
    opts="migration setup database completions print-schema help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__completions)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__database)
    opts="setup reset drop"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__database__drop)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__database__reset)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__database__setup)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__migration)
    opts="run revert redo list pending generate"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__migration__generate)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__migration__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__migration__pending)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__migration__redo)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__migration__revert)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__migration__run)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__print__schema)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__help__setup)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help run revert redo list pending generate help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__generate)
    opts="-u -o -e -h --version --no-down --format --diff-schema --sqlite-integer-primary-key-is-bigint --only-tables --except-tables --schema-key --migration-dir --database-url --config-file --locked-schema --help <MIGRATION_NAME> [table-name]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --version)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --format)
      COMPREPLY=($(compgen -W "sql" -- "${cur}"))
      return 0
      ;;
    --diff-schema)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --schema-key)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__help)
    opts="run revert redo list pending generate help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__help__generate)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__help__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__help__pending)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__help__redo)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__help__revert)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__help__run)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__list)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__pending)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__redo)
    opts="-a -n -h --all --number --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --number)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__revert)
    opts="-a -n -h --all --number --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --number)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__migration__run)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__print__schema)
    opts="-s -o -e -h --schema --only-tables --except-tables --with-docs --with-docs-config --column-sorting --patch-file --import-types --no-generate-missing-sql-type-definitions --except-custom-type-definitions --custom-type-derives --schema-key --sqlite-integer-primary-key-is-bigint --database-url --config-file --locked-schema --help [table-name]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --schema)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -s)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --with-docs-config)
      COMPREPLY=($(compgen -W "database-comments-fallback-to-auto-generated-doc-comment only-database-comments no-doc-comments" -- "${cur}"))
      return 0
      ;;
    --column-sorting)
      COMPREPLY=($(compgen -W "ordinal_position name" -- "${cur}"))
      return 0
      ;;
    --patch-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --import-types)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --except-custom-type-definitions)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --custom-type-derives)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --schema-key)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  diesel__setup)
    opts="-h --migration-dir --database-url --config-file --locked-schema --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --migration-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --database-url)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
  complete -F _diesel -o nosort -o bashdefault -o default diesel
else
  complete -F _diesel -o bashdefault -o default diesel
fi

PS1="\e[1;36m\u@\h \W -> \e[0m"
PS2="\e[1;36m> \e[0m"

# pnpm
export PNPM_HOME="/home/fellipe/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
