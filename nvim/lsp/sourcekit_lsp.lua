return {
	cmd = {
		"sourcekit-lsp",
	},
	filetypes = {
		"swift",
	},
	root_markers = {
        "Package.swift",
        ".git",
        ".jj"
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}
