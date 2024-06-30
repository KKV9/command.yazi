# cmd_prompt.yazi

A Yazi plugin that displays a command prompt for yazi commands.

## Install

```bash
git clone https://github.com/KKV9/cmd_prompt.yazi.git ~/.config/yazi/plugins/cmd_prompt.yazi
```

## Usage

- Add this to your `keymap.toml`:

```toml
[manager]
prepend_keymap = [
  { on = [
    "c",
    "p",
  ], run = "plugin cmd_prompt", desc = "Yazi command prompt" },
]
```

 - Press `c` `p` to display the prompt.
 - Type any yazi command. 
 - Multiple words should be placed in double quotes. e.g. `shell "ls -l | less" --block --confirm`
 - Flags can be assigned values either with equals or space. e.g. `rename --empty=stem` or `rename --empty stem`
 
