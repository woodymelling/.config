export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="refined"
plugins=(vi-mode)

VI_MODE_SET_CURSOR=true
source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export VISUAL="$EDITOR"
set -o vi
compinit


# initialize zoxide
eval "$(zoxide init --cmd cd zsh)"

#
# ────────────────────────────────────────────────────────────────────────────────
# Prevent “nvim” from launching inside itself: if NVIM is set, use --remote-send.
# Paste this into your ~/.config/zsh/.zshrc (or ~/.zshrc) near the top.
# Make sure it runs before you try to use `nvim` in any other alias or plugin.
# ────────────────────────────────────────────────────────────────────────────────
#

# 1) Grab the path to the “real” nvim binary once, so we don’t recurse:
typeset -g ORIGINAL_NVIM="$(command -v nvim)"


# 2) Override `nvim` with a shell function:
nvim() {
  local open_cmd

  # If any arguments were passed (e.g. nvim file1 file2), use `:e …`; else use :Alpha
  if (( $# )); then
    # Join all positional args into a single “:e <…>” string
    open_cmd=":e ${*}"
  else
    open_cmd=":Alpha"
  fi

  # If $NVIM is non-empty, we assume we’re already inside an nvim server session.
  if [[ -n "$NVIM" ]]; then
    # Send a remote command to the existing server; first leave Terminal mode (<C-\><C-N>),
    # cd to the current working directory, then run our open_cmd.
    "$ORIGINAL_NVIM" \
      --server "$NVIM" \
      --remote-send "<C-\\><C-N>:silent tcd $PWD<CR>${open_cmd}<CR>"
  else
    # No NVIM server—just call the real nvim with whatever args were given.
    "$ORIGINAL_NVIM" "$@"
  fi
}
