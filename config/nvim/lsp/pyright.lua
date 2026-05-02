vim.lsp.config('pyright', {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "py" },
  root_markers = {
		'pyproject.toml',
		'setup.py',
		'setup.cfg',
		'requirements.txt',
		'.git',
  },

	single_file_support = true,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
			}
		}
	}
})

