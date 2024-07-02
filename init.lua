return {
	entry = function()
		-- Table to store parsed parameters and flags
		local params = {}

		-- Function to set a flag in the params table
		local function set_flag(name, value)
			-- Remove '--' prefix from the flag and set it in params
			params[name:gsub("%-%-", "")] = value or true
		end

		-- Function to check if flag is valid
		local function is_flag_in_allowed(test_flag, allowed_list)
			for _, flag in ipairs(allowed_list) do
				if flag == test_flag then
					return true
				end
			end
			return false
		end

		-- Function to send error notifications
		local function notify_error(message)
			ya.notify({
				title = "Yazi Command",
				content = message,
				level = "warn",
				timeout = 5,
			})
		end

		-- Define all commands and their flags
		local command_flags = {
			escape = { "--all", "--find", "--visual", "--select", "--filter", "--search" },
			quit = { "--no-cwd-file" },
			leave = {},
			enter = {},
			back = {},
			seek = {},
			cd = { "--interactive" },
			reveal = {},
			select = { "--state" },
			select_all = { "--state" },
			visual_mode = { "--unset" },
			open = { "--interactive", "--hovered" },
			yank = { "--cut" },
			unyank = {},
			paste = { "--force", "--follow", "--before" },
			link = { "--relative", "--force" },
			remove = { "--force", "--permanently", "--hovered" },
			create = { "--force" },
			rename = { "--hovered", "--force", "--empty", "--cursor" },
			copy = {},
			shell = { "--confirm", "--block", "--orphan" },
			hidden = {},
			linemode = {},
			search = {},
			find = { "--previous", "--smart", "--insensitive" },
			find_arrow = { "--previous" },
			filter = { "--smart", "--insensitive" },
			sort = { "--reverse", "--dir-first", "--translit" },
			tab_create = { "--current" },
			tab_switch = { "--relative" },
			tab_swap = {},
			tasks_show = {},
			close = { "--submit" },
			arrow = {},
			inspect = {},
			cancel = {},
			plugin = { "--args" },
			move = { "--in-operating" },
			backword = {},
			forward = { "--end-of-word" },
			insert = { "--append" },
			visual = {},
			delete = { "--cut", "--insert" },
			undo = {},
			redo = {},
			help = {},
			backspace = { "--under" },
			kill = {},
			close_input = {},
		}

		-- Get input from the user with a prompt window
		local command, event = ya.input({
			title = "Command:", -- Title of the input prompt
			position = { "top-center", y = 3, w = 40 }, -- Positioning details
		})

		-- Check if the input was cancelled or closed
		if event ~= 1 then
			return -- Exit if input was not provided
		end

		-- Extract the main command (the first word before any space)
		local main_command = command:match("^[^%s]+") or ""

		-- Get the list of allowed flags for this command
		local allowed_flags = command_flags[main_command]

		-- If the command is not valid, display an error and exit
		if not allowed_flags then
			notify_error(string.format('Command "%s" is not a valid command', main_command))
			return
		end

		-- Extract flags and their values from the command string
		for flag, value in command:gmatch("(%-%-%S*)%s*=?%s*(%w*)") do
			-- Split flag if not already separated
			flag = flag:gsub("%s*", "")
			if flag:match("=") then
				flag, value = string.match(flag, "([^=]+)=(.*)")
			end

			-- Exit if flag is not valid
			if not is_flag_in_allowed(flag, allowed_flags) then
				notify_error(string.format("%s is not a valid flag for %s", flag, main_command))
				return
			else
				set_flag(flag, value ~= "" and value or nil)
			end
		end

		-- Extract the secondary command
		-- (First and last double quotes in the string or
		-- the first word after a space that is not a flag)
		local secondary_command = command:match('%s+"(.-)"%s*$') or command:match("%s+([^%s-][^%s]*)") or ""

		-- Insert the secondary command into params table
		table.insert(params, tostring(secondary_command))

		-- Execute the main command with the parsed parameters
		ya.manager_emit(tostring(main_command), params)
	end,
}
