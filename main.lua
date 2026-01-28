--- @since 25.12.29

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

return {
	entry = function()
		-- Define all commands and their flags
		local command_flags = {
			escape = { "--all", "--find", "--visual", "--select", "--filter", "--search" },
			quit = { "--code", "--no-cwd-file" },
			close = { "--code", "--no-cwd-file" },
			suspend = {},
			arrow = {},
			leave = {},
			enter = {},
			back = {},
			forward = {},
			seek = {},
			spot = {},
			cd = { "--interactive" },
			reveal = {},
			toggle = { "--state" },
			toggle_all = { "--state" },
			visual_mode = { "--unset" },
			open = { "--interactive", "--hovered" },
			yank = { "--cut" },
			unyank = {},
			paste = { "--force", "--follow" },
			link = { "--relative", "--force" },
			hardlink = { "--force", "--follow" },
			remove = { "--force", "--permanently", "--hovered" },
			create = { "--dir", "--force" },
			rename = { "--hovered", "--force", "--empty", "--cursor" },
			copy = { "--separator", "--hovered" },
			shell = { "--confirm", "--block", "--orphan", "--interactive", "--cursor" },
			hidden = {},
			linemode = {},
			search = { "--via", "--args" },
			find = { "--previous", "--smart", "--insensitive" },
			find_arrow = { "--previous" },
			filter = { "--smart", "--insensitive" },
			sort = { "--reverse", "--dir-first", "--translit" },
			tab_create = { "--current" },
			tab_close = {},
			tab_switch = { "--relative" },
			tab_swap = {},
			help = {},
			plugin = { "--args" },
			noop = {},
		}

		-- Get input from the user with a prompt window
		local command, event = ya.input({
			title = "Command:", -- Title of the input prompt
			pos = { "top-center", y = 3, w = 40 }, -- Positioning details
		})

		-- Check if the input was cancelled or closed
		if event ~= 1 then
			return -- Exit if input was not provided
		end

		-- Extract the main command (the first word before any space)
		local main_command = command:match("^[^%s]+") or ""
		-- Extract the secondary command
		-- (First and last double quotes in the string or
		-- the first word after a space that is not a flag --)
		local secondary_command = command:match('"(.*)"') or command:match("%s+([^%s-][^%s]*)") or ""
		-- Get the list of allowed flags for this command
		local allowed_flags = command_flags[main_command]
		-- Store flags along with their arguments
		local flags = {}
		local current_flag = nil
		-- If the command is not valid, display an error and exit
		if not allowed_flags then
			notify_error(string.format('Command "%s" is not a valid command', main_command))
			return
		end

		command = command:gsub("=", " "):gsub("'", ""):gsub('".-"', "")
		for word in command:gmatch("[^%s]+") do
			if word:match("^%-%-") then
				if not is_flag_in_allowed(word, allowed_flags) then
					notify_error(string.format("%s is not a valid flag for %s", word, main_command))
					return
				end
				current_flag = word:sub(3) -- Remove the leading --
				flags[current_flag] = "yes" -- Initialize the flag in the table
			elseif current_flag then
				if flags[current_flag] == "yes" then
					flags[current_flag] = word:gsub("\\%-", "-") -- Allow escaping --
				else
					flags[current_flag] = string.format("%s %s", flags[current_flag], word:gsub("\\%-", "-"))
				end
			end
		end

		-- Insert the secondary command into params table
		table.insert(flags, tostring(secondary_command))

		-- Execute the main command with the parsed parameters
		ya.mgr_emit(tostring(main_command), flags)
	end,
}
