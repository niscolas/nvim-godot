<div align="center">
  <img src="https://avatars.githubusercontent.com/u/6471485?s=200&v=4" alt="Neovim logo" width="100">
  <img src="https://godotengine.org/assets/press/icon_color_outline.svg" alt="Godot logo" width="100">
</div>

# nvim-godot
Use Neovim as your Godot code editor

## ✨ Features
- A step-by-step guide on how to setup a dev environment in Neovim to work seamlessly with Godot
- A good looking minimal Neovim config with IDE-like features, similar to Godot's built-in editor
- An executable file to be used on Godot's `External Editor Settings` allowing to open files directly on Neovim
- A Docker Image packed with the Minimal Neovim Config for a quick setup without any installation required

## ⚡🐋 Quick Start / Docker
To get up and running quickly, or to test the setup, you can just run the following command if you have Docker installed:

```
docker run -it -p 6005:6005 -p 6006:6006 niscolas/nvim-godot:latest
```

> 💡 One important thing to note is that the some error messages will appear on Neovim startup related to the Lua Language Server since it doesn't support Alpine (the base image)

### ➕ Additional Info
> 💡 You can add the `--rm` option to remove the container as soon as you're finished with testing

```
docker run --rm -it -p 6005:6005 -p 6006:6006 niscolas/nvim-godot:latest
```

> ⚠️ And you can add the `--network host` option to be able to use the host machine (your PC probably) network (I normally have to use it since I broke my Docker settings), but it's advised against

```
docker run --network host -it niscolas/nvim-godot:latest
```



## ✏️ External Editor Settings
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

## The `run.sh` Executable
(WIP)
