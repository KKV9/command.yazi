# command.yazi

A Yazi plugin that displays a command prompt for yazi commands.

## Install

```bash
# For Unix platforms
git clone https://github.com/KKV9/command.yazi.git ~/.config/yazi/plugins/command.yazi

## For Windows
git clone https://github.com/KKV9/command.yazi.git %AppData%\yazi\config\plugins\command.yazi

# Or with yazi plugin manager
ya pack -a KKV9/command
```

- Add this to your `keymap.toml`:

```toml
[[manager.prepend_keymap]]
on   = [ "c", "p" ]
run  = "plugin command"
desc = "Yazi command prompt"
```

## Usage

 - Press `c` `p` to display the prompt.
 - Type any yazi command. e.g `select_all`
 - Parameters are assumed to be flags and default to the value "yes". e.g. `yank --cut` is equivalent to `yank --cut=yes` 
 - Parameters can be assigned values either with an equals or a space. e.g. `rename --empty=stem` or `rename --empty stem`
 - Parameters can be assigned multiple arguments separated by a space. e.g. `plugin example --args arg1 arg2 arg3`
 - Multiple words that are NOT arguments should be placed in double quotes. e.g. `shell "ls -l | less" --block --confirm`
 - Argument values begining with `--` are assumed to be arguments and should be escaped . e.g. use `plugin shell --args=\--block`
