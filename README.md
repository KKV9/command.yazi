# command.yazi

A Yazi plugin that displays a command prompt for yazi commands.

## Install

```bash
# With git
git clone https://github.com/KKV9/command.yazi.git ~/.config/yazi/plugins/command.yazi
# Or with yazi plugin manager
ya pack -a KKV9/command
```

## Usage

- Add this to your `keymap.toml`:

```toml
[[manager.prepend_keymap]]
on   = [ "c", "p" ]
run  = "plugin command"
desc = "Yazi command prompt"
```

 - Press `c` `p` to display the prompt.
 - Type any yazi command. e.g `select_all`
 - Arguments given default to "yes". e.g. `yank --cut` is equivalent to `yank --cut=yes` 
 - Args can be assigned values either with equals or space. e.g. `rename --empty=stem` or `rename --empty stem`
 - Args can be assigned multiple values separated by a space. e.g. `plugin example --args arg1 arg2 arg3`
 - Multiple words that are NOT argument values should be placed in double quotes. e.g. `shell "ls -l | less" --block --confirm`
