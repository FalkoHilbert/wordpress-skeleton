#!/usr/bin/env bash
set -o nounset
set -o errexit
set -o pipefail

declare no_symlinks='on'

# Linux/Mac abstraction
function get_realpath(){
    [[ ! -f "$1" ]] && return 1 # failure : file does not exist.
    [[ -n "$no_symlinks" ]] && local pwdp='pwd -P' || local pwdp='pwd' # do symlinks.
    echo "$( cd "$( echo "${1%/*}" )" 2>/dev/null; $pwdp )"/"${1##*/}" # echo result.
    return 0
}

# Set magic variables for current FILE & DIR
declare -r __FILE__=$(get_realpath ${BASH_SOURCE[0]})
declare -r __DIR__=$(dirname "$__FILE__")

declare -r __WPPath__="$__DIR__/../public/wp"

# Coloring/Styling helpers
esc=$(printf '\033')
reset="${esc}[0m"
blue="${esc}[34m"
yellow="${esc}[33m"
green="${esc}[32m"
red="${esc}[31m"
bold="${esc}[1m"
warn="${esc}[41m${esc}[97m"

function printError(){
    >&2 echo -e "$@"
}

function finish {
    echo "${reset}"
}
trap finish EXIT