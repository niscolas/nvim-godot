#!/usr/bin/env bash

# CHANGE IF NEEDED: 
# - replace with your Terminal Emulator executable
term_exec="wezterm"
# - replace with your Neovim executable
nvim_exec="nvim"
# - replace with other path for the Neovim server pipe
server_path="$HOME/.cache/nvim/godot-server.pipe"
# - if you don't get the gdscript in nvim on startup increase this number NOTE: delay is in seconds
server_startup_delay=0.1

start_server() {
    "$term_exec" -e "$nvim_exec" --listen "$server_path"
}

open_file_in_server() {
    # - escape stuff because nvim will not
    filename=$(printf %q "$1")
    "$term_exec" -e "$nvim_exec" --server "$server_path" --remote-send "<C-\><C-n>:n $filename<CR>:call cursor($2)<CR>"
}

if ! [ -e "$server_path" ]; then
    # - start server FIRST then open the file
    start_server &
    sleep $server_startup_delay # - wait for the server to start 
    open_file_in_server "$1" "$2"
else
    open_file_in_server "$1" "$2"
fi
