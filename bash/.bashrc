# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# ^ not in use, life is too short to learn bash
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# aliases
alias lsl='echo;ls -AC'
alias dev='cd ~/Development'

#functions
mvf() {
    local source="$1"
    local dest="$2"

    # Check if source exists
    if [ ! -d "$source" ]; then
        echo "Source folder does not exist!"
        return 1
    fi

    # Check if destination exists, create if not
    if [ ! -d "$dest" ]; then
        mkdir -p "$dest"
    fi

    # Move only files (not directories)
    find "$source" -maxdepth 1 -type f -exec mv {} "$dest"/ \;

    echo "Files moved from '$source' to '$dest'."
}

eval "$(starship init bash)"
