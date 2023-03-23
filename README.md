↖️ Table of Contents

<div align="center">
  <img src="https://avatars.githubusercontent.com/u/6471485?s=200&v=4" alt="Neovim logo" width="100">
  <img src="https://godotengine.org/assets/press/icon_color_outline.svg" alt="Godot logo" width="100">
</div>

# nvim-godot
Use Neovim as your Godot code editor

## ✨ Features
- ❓ A step-by-step guide on how to setup a dev environment in Neovim to work seamlessly with Godot
- 🔋 A good looking minimal Neovim config with IDE-like features
- 🏃 An executable file to allow Godot to open files directly into Neovim
- 🐋 A Docker Image packed with the Minimal Neovim Config for a quick setup

## ⚡ Getting Started

1. [🛠️ Installation and Setup](#installation-and-setup-section)
2. [🏃 The `run.sh` File](#run-sh-section)
3. [🤖 Godot External Editor Settings](#godot-external-editor-settings-section)

<a id="installation-and-setup-section"></a>
## 🛠️ Installation and Setup

To be able to leverage the power of the Neovim-Godot integration, you can follow one of these paths:

### 🐋 Docker
To get up and running quickly, or to test the setup, you can just run the following command if you have Docker installed:

```
docker run -it -p 6005:6005 -p 6006:6006 niscolas/nvim-godot:latest
```

> 💡 One important thing to note is that the some error messages will appear on Neovim startup related to the Lua Language Server since it doesn't support Alpine (the base image)

#### ➕ Additional Info
> 💡 You can add the `--rm` option to remove the container as soon as you're finished with testing

```
docker run --rm -it -p 6005:6005 -p 6006:6006 niscolas/nvim-godot:latest
```

> ⚠️ And you can add the `--network host` option to be able to use the host machine (your PC probably) network (I normally have to use it since I broke my Docker settings), but it's advised against

```
docker run --network host -it niscolas/nvim-godot:latest
```

### ⬇️  Using the Minimal Neovim Config in your machine

- Can be done by cloning the repo and moving the [nvim_config/](nvim_config/) directory to your `$HOME/.config/nvim`

**OR** 

- With this simple script:

    > ⚠️  Your current Neovim config will be moved to `$HOME/.config/nvim.old`, make sure that it's already in you Version Control system or that you know what you're doing)

    ```
    mv $HOME/.config/nvim $HOME/.config/nvim.old && \
    git clone https://github.com/niscolas/nvim-godot && \
    mv nvim-godot/nvim_config $HOME/.config/nvim
    ```

<!-- ### 🔄 Updating your Neovim Config to support Godot -->

<a id="run-sh-section"></a>
## 🏃 The `run.sh` File
The [run.sh](run.sh) is an executable `bash` file responsible for opening your terminal and launching Neovim with the correct file (line and column) opened.

You may need to edit it to fit your needs, the places where changes maybe be needed are commented in the file itself.

<a id="godot-external-editor-settings-section"></a>
## 🤖 Godot External Editor Settings
1. In Godot, go to `Editor > Editor Settings... > (General Tab) > Text Editor > External`
2. Set `Use External Editor` to ✅
3. Set `Exec Path` to the location of the `run.sh` file on your system 
4. Set `Exec Flags` to `"{file}" "{line},{col}"`
<details>
<summary>Step-by-Step with Images </summary>
<img src="https://i.imgur.com/VMHHR5a.png">
<img src="https://i.imgur.com/h7nQZkm.png">
<img src="https://i.imgur.com/u4Czaff.png">
</details>

## ⚙️  The Neovim Config
### 👉  Introduction
> ⚠️ In order for the LSP features to work, you need a running instance of Godot 4

Out of the box you should have:
- ➡️ Autocompletion (integrated with LSP and Snippets)
- 🧠 General LSP features, just like in Godot's built-in Editor:
    - 🌐 Go to Definition
    - 🚦 Linting
- 🌸 A nice looking theme (with GDScript highlighting)

### 🌸 *aesthetics*
This is the default look of the custom Neovim Config included in this repo: ([🌲 *everforest theme*](https://github.com/sainnhe/everforest))
> 💡 Screenshots taken from the Neovim instance running on the Docker container!

<img src="https://i.imgur.com/YtchKbV.png">
<details>
<summary>Extra screenshots</summary>
<img src="https://i.imgur.com/qVhgZZy.png">
<img src="https://i.imgur.com/en5rDnZ.png">
</details>

### 📦 Settings and Plugins
Most of the Neovim config was copied from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), with the theme change and the Godot specific LSP, TreeSitter and DAP settings
