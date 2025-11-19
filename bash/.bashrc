# .bashrc

# Source directory
BASHRC_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH


# ultra secret aliases from untracked file (top secret)

if [ -f "$BASHRC_DIR/.bash_aliases" ]; then
    . "$BASHRC_DIR/.bash_aliases"
fi


# Commitable aliases
alias lsl='echo;ls -AC'
alias dev='cd ~/Development'


# Functions
tmux-kill-all() {
    # map every tmux session entry to array
    mapfile -t sessions < <(tmux ls | cut -d: -f1)

    if [ ${#sessions[@]} -lt 1 ]; then
        echo "There are no sessions!"
        return 1
    fi

    count=0
    for name in "${sessions[@]}"; do
        tmux kill-session -t "$name"
        count=$((count + 1))
    done

    echo "Done! Total deleted sessions: $count"
}

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
