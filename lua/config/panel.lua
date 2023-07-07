--lua/code_action_utils.lua
local M = {}
local lsp_util = vim.lsp.util

function M.OPenFloatingWindow()
	-- set local options
	local term_id = vim.api.nvim_open_term(0, {})
	local function send_output(_, data, _)
		for _, d in ipairs(data) do
			vim.api.nvim_chan_send(term_id, data .. "\n")
		end
	end
	vim.fn.jobstart("command that produces a colored output", { on_stdout = send_output })
end

function M.code_action_listener()
	local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
	local params = lsp_util.make_range_params()
	params.context = context
	vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, _, result)
		-- do something with result - e.g. check if empty and show some indication such as a sign
		if err or vim.tbl_isempty(result) then
			for k, v in ipairs(result) do
				print(k, v)
			end
			return
		end
	end)
end

return M
