#!/bin/bash

## for unhandled errors and not initialised var
set -e
set -u

## for making sure user initialised var that one var they should have
if [ -z "${1:-}" ]; then
    printf "Error: provide path to dotfiles directory!\n"
    exit 1
fi

## consts and commands
DOTFILES_DIR="$1"
CONFIG_DIR="${HOME}/.config/"
CONFIG_NAMES=("alacritty" "nvim" "starship")

## ----- bash part -----
## HOME_NAMES=("bash") - for now only bash so I just skip it
## bash behaves differently anyway
BASH_DOTFILES="${DOTFILES_DIR}/bash/.bashrc"
BASH_HOME="${HOME}/.bashrc"
## -----    end    -----

LOCK_STATUS="/var/lock/dotfiles-script-lock-dir"
cmd_locking="mkdir ${LOCK_STATUS}"
cmd_check_lock="test -d ${LOCK_STATUS}"
cmd_unlocking="rm -rf ${LOCK_STATUS}"
cmd_rm="rm -v"
cmd_mv="mv"
cmd_cp="cp"
cmd_ln_config="ln -sv -t ${CONFIG_DIR}"
cmd_ln_home="ln -sv -t ${HOME}"
cmd_ln_crude="ln -sv"

## checks if lock is active
## 1 (true) - lock is active
## 0 (false) - lock is not active or error happend
function is_running()
{
    local cmd_check_lock=$1

    ${cmd_check_lock} || {
        return 1
    }
    
    return 0
}

## creates lock
function create_lock()
{
    local cmd_locking=${1}

    ${cmd_locking} || {
        printf "Cannot create lock\n"
        exit 2
    }
}
 
## removes lock
function remove_lock() 
{
    local cmd_unlocking="${1}"
    ${cmd_unlocking} || {
        printf "Cannot unlock\n"
        exit 3
    }
}

## creates symlink
function create_symlink()
{
    local cmd_ln_config="$1 $2"

    ${cmd_ln_config} || {
        printf "Cannot create symlink\n"
        remove_lock "${cmd_unlocking}"
        exit 5
    }
}

## checks and deletes symlink
function check_and_delete_symlink()
{
    local cmd_rm="$1"
    local target_link="$2"
    local name="$3"

    if [ -L "${target_link}" ] ; then
        printf "[!] Link for ${name} exists! Replacing it now...\n"
        ${cmd_rm} "${target_link}" || {
            printf "Cannot delete symlink\n"
            remove_lock "${cmd_unlocking}"
            exit 6
        }
    fi
}

## main function
function main()
{
    ## for panic if something happens during script execution
    trap 'remove_lock "${cmd_unlocking}"; exit 130' SIGINT SIGTERM

    if is_running "${cmd_check_lock}" ; then
        printf "Lock is present (instance already running?) - exiting.\n"
        exit 1
    fi

    ## creating lock, actual script begins from here <-----------
    create_lock "${cmd_locking}"

    cd "${CONFIG_DIR}" || {
        remove_lock "${cmd_unlocking}"
        printf "Cannot enter to working dir.\n" >&2
        exit 4
    }

    ## symlinking what needs to be symlinked in config
    for name in "${CONFIG_NAMES[@]}"; do
        current_symlinked_dir="${DOTFILES_DIR}/${name}"
        target_link="${CONFIG_DIR}/${name}"

        check_and_delete_symlink "${cmd_rm}" "${target_link}" "${name}"
        create_symlink "${cmd_ln_config}" "${current_symlinked_dir}"
    done

    ## now the same for bash
    if [ -f "${BASH_HOME}" ] ; then
        printf "[!] .bashrc exists! Replacing it now..."
        ${cmd_rm} "${BASH_HOME}" || {
            printf "Cannot delete symlink\n" >&2
            exit 6
        }
    fi

    create_symlink "${cmd_ln_home}" "${BASH_DOTFILES}"

    ## end of script <-----------
    remove_lock "${cmd_unlocking}"

    printf "Files has been symlinked!"
    exit 0
}

## menu
clear
printf "==============================\n"
printf "     DOTFILES: by T.Dyrka\n"
printf "==============================\n"
printf "1. Start symlinking from:\n"
printf "${DOTFILES_DIR}\n"
printf "2. Quit\n\n"
    

while true; do
    read -n 1 -p "[1/2]: " choice
    printf "\n"

    case $choice in
        1)
            printf "Starting script...\n"
            main
            ;;
        2)
            printf "Quitting...\n"
            exit 0
            ;;
        *)
            printf "Error: Are you sure you picked 1 or 2?\n"
            ;;
    esac
done
