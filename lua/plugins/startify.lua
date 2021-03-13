
vim.g.startify_session_dir = '~/.config/nvim/session'


vim.g.startify_lists = {
          { 'type': 'files',     'header': ['   Files']                        },
          { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          { 'type': 'sessions',  'header': ['   Sessions']                     },
          { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
         }


vim.g.startify_session_autoload = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1

vim.g.webdevicons_enable_startify = 1

-- function! StartifyEntryFormat()
--         return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
--     endfunction

vim.g.startify_bookmarks = [
             { 't': '~/.config/kitty/kitty.conf' },
             { 'i': '~/.config/nvim/init.vim' },
             { 'z': '~/.zshrc' },
             '~/dev',
             '~/Downloads',
             '~/Desktop']

vim.g.startify_enable_special = 1
