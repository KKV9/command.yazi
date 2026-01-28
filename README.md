# command.yazi

A plugin for Yazi that provides a command palette for executing commands interactively.

## Install

```bash
# For Unix platforms
git clone https://github.com/KKV9/command.yazi.git ~/.config/yazi/plugins/command.yazi

## For Windows
git clone https://github.com/KKV9/command.yazi.git %AppData%\yazi\config\plugins\command.yazi

# Or with yazi plugin manager
ya pkg add KKV9/command
```

- Add this to your `keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on   = [ "c", "p" ]
run  = "plugin command"
desc = "Open command palette"
```


## Usage

### Basic Usage

1. Press `c` then `p` to open the command palette
2. Type any Yazi command (e.g., `toggle_all`, `yank`, `rename`)
3. Press Enter to execute

### Command Syntax

**Simple commands:**
```
quit
open
yank
```

**Commands with flags:**
```
yank --cut
toggle --state=on
remove --force --permanently
```

**Commands with arguments:**
```
cd ~/Downloads
arrow 5
```

**Commands with multi-word arguments (use quotes):**
```
cd "~/My Documents"
shell "ls -l | less" --block
```

### Flag Syntax Rules

**Flags default to "yes":**
- `yank --cut` is equivalent to `yank --cut=yes`
- `remove --force` is equivalent to `remove --force=yes`

**Flags can use `=` or space for values:**
- `rename --empty=stem` (using equals)
- `rename --empty stem` (using space)
- Both are valid and equivalent

**Multiple arguments for a single flag:**
```
plugin example --something "arg1 arg2 arg3"
sort --reverse --dir-first
```

**Escaping `--` in argument values:**
- If an argument value starts with `--`, escape it with a backslash
- Example: `plugin shell --args=\--block`
- This prevents `--block` (a plugin argument) from being interpreted as a yazi command argument

### Complete Examples

```
# Toggle selection state
toggle --state=on

# Yank files in cut mode
yank --cut

# Remove files permanently without confirmation
remove --force --permanently

# Change directory interactively
cd --interactive

# Execute shell command with blocking
shell "btop" --block

# Rename with empty stem and cursor at start
rename --empty=stem --cursor=start

# Search using fd with custom arguments
search --via=fd --args=-H

# Create directory with force overwrite
create --force --dir

# Open file interactively
open --interactive

# Sort by modified time, reversed, directories first
sort mtime --reverse --dir-first
```

## Supported Commands

The plugin validates commands and flags against the current Yazi command set. See the [Yazi keymap documentation](https://yazi-rs.github.io/docs/configuration/keymap/) for a complete list of available commands and their options.

### Common Commands

- `arrow` - Move cursor up/down
- `cd` - Change directory
- `copy` - Copy file path/name
- `create` - Create file/directory
- `enter` - Enter directory
- `filter` - Filter files
- `find` - Find files
- `hidden` - Toggle hidden files
- `leave` - Go to parent directory
- `open` - Open file
- `paste` - Paste yanked files
- `quit` - Exit Yazi
- `remove` - Remove/trash files
- `rename` - Rename file
- `search` - Search files
- `shell` - Execute shell command
- `sort` - Sort files
- `toggle` - Toggle file selection
- `yank` - Yank (copy) files
