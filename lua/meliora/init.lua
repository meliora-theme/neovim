function Return_error(msg)
    error('Meliora: ' .. msg)
end

function Print_error(msg)
    print('Error: Meliora: ' .. msg)
end

local M = {}

-- default config
M.config = {
    dim_inactive = false,
    neutral = true,
    color_set = 'mellifluous',
    styles = {
        comments = 'italic',
        conditionals = 'NONE',
        folds = 'NONE',
        loops = 'NONE',
        functions = 'NONE',
        keywords = 'NONE',
        strings = 'NONE',
        variables = 'NONE',
        numbers = 'NONE',
        booleans = 'NONE',
        properties = 'NONE',
        types = 'NONE',
        operators = 'NONE',
    },
    transparent_background = {
        enabled = false,
        floating_windows = false,
        telescope = true,
        file_tree = true,
        cursor_line = true,
        status_line = false,
    },
    plugins = {
        cmp = true,
        indent_blankline = true,
        nvim_tree = {
            enabled = true,
            show_root = false,
        },
        telescope = {
            enabled = true,
            nvchad_like = true,
        },
        startify = true,
    },
}

function M.setup(config)
    M.config = vim.tbl_deep_extend('force', M.config, config or {})
end

M.load = function()
    local lush = require 'lush'
    local colors, is_bg_dark = require 'meliora.color_sets'.get_colors(M.config.color_set)
    M.config.dark = is_bg_dark

    require 'meliora.cli'(M.config)
    require 'meliora.terminal'(colors)

    local highlights = require 'meliora.highlights'(colors)
    local specs = require 'meliora.plugins'(highlights, colors)
    table.insert(specs, highlights)

    return lush.merge(specs)
end

return M
