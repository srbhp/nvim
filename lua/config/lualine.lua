-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.
local empty = require("lualine.component"):extend()
function empty:draw(default_highlight)
	self.status = "   "
	self.applied_separator = "   "
	self:apply_highlights(default_highlight)
	self:apply_section_separators()
	return self.status
end
-- stylua: ignore
-- local function searchCount()
--     local search = vim.fn.searchcount({maxcount = 0})
--         -- maxcount = 0 makes the number not be capped at 99
--     local searchCurrent = search.current
--     local searchTotal = search.total
--     if searchCurrent > 0 then
--         return "/"..vim.fn.getreg("/").." ["..searchCurrent.."/"..searchTotal.."]"
--     else
--         return ""
--     end
-- end

local treesitter = require('nvim-treesitter')
local function treelocation()
	local f = treesitter.statusline({
		indicator_size = 300,
		type_patterns = {
			"class",
			"function",
			"method",
			"interface",
			"type_spec",
			"table",
			"if_statement",
			"for_statement",
			"for_in_statement",
		},
	})
	local context = string.format("%s", f) -- convert to string, it may be a empty ts node
	if context == "vim.NIL" then
		return " "
	end
	if context == "nil" then
		return " "
	end

	return " " .. context
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		-- theme = bubbles_theme,
		component_separators = "|",
		section_separators = { left = "", right = "" },
		--     section_separators = { left = '', right = '' },
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{
				"mode",
				separator = { left = "", right = "" },
				right_padding = 2,
				left_padding = 2,
				padding = 2,
			},
		},
		lualine_b = {
			{
				"filename",
				separator = { left = "", right = "" },
			},
			{
				empty,
			},
			{
				"branch",
				separator = { right = "", left = "" },
			},
			{
				"fileformat",
				separator = { right = "", left = "" },
				left_padding = 4,
				right_padding = 4,
			},
		},
		lualine_x = {},
		lualine_y = { { "progress", separator = { left = "", right = "" } } },
		lualine_z = {
			{
				"location",
				separator = { left = "", right = "" },
				left_padding = 2,
				right_padding = 2,
			},
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	winbar = {
		lualine_a = {
			{
				"buffers",
				separator = { left = "", right = "" },
				right_padding = 2,
				symbols = { alternate_file = "" },
			},
		},
		lualine_b = { { treelocation } },
		-- max_length = vim.o.columns,
		lualine_y = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				update_in_insert = true,
				separator = { left = "", right = "" },
			},
			-- {
			-- 	searchCount,
			-- 	separator = { left = "", right = "" },
			-- 	left_padding = 2,
			-- 	right_padding = 2,
			-- 	padding = 2,
			-- },
			{
				empty,
			},
			{
				"filetype",
				separator = { left = "", right = "" },
			},
			{
				empty,
			},
			-- { "filetype", separator = { left = "", right = "" } },
		},
	},
	extensions = {},
})
