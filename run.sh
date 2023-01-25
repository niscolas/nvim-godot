#!/usr/bin/env bash

# replace with your terminal
term_exec=kitty

server_path=$HOME/.cache/nvim/godot-server.pipe

if ! [ -e $server_path ]; then
    # start the server if its pipe doesn't exist
    $term_exec nvim --listen $server_path $1
fi

# open file in server
$term_exec nvim --server $server_path --remote-send "<C-\><C-n>:n $1<CR>:call cursor($2)<CR>"
