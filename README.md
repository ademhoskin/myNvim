# Comprehensive Neovim IDE Configuration

A lightweight yet powerful Neovim configuration optimized for navigating large codebases with full IDE capabilities.

## Table of Contents
- [Features](#features)
- [Plugin Stack](#plugin-stack)
- [Installation](#installation)
- [Configuration Structure](#configuration-structure)
- [Keybindings Reference](#keybindings-reference)
- [Performance Optimizations](#performance-optimizations)
- [Language Support](#language-support)
- [Advanced Usage](#advanced-usage)
- [Troubleshooting](#troubleshooting)

## Features

### Core IDE Capabilities
- **Symbol Navigation** - Jump to definitions, implementations, references
- **Symbol Renaming** - Project-wide symbol renaming with LSP
- **Code Actions** - Auto-fixes, refactoring suggestions
- **Advanced Search** - Fuzzy file finding, live grep with filters
- **Git Integration** - Status, blame, log, diff viewing
- **Session Management** - Auto-restore project sessions
- **File Browser** - Fast directory navigation with Oil.nvim
- **Debugging Support** - Breakpoints and debug controls
- **Multiple Language Support** - C/C++, Python, JavaScript/TypeScript, Go, Rust, Ruby, SQL, HTML/CSS

### Performance Features
- **Lazy Loading** - Plugins load only when needed
- **Large File Handling** - Optimized for codebases with thousands of files
- **Smart Ignoring** - Skips node_modules, .git, build directories
- **Memory Optimization** - Reduced memory usage for better performance
- **Fast Startup** - Sub-100ms startup time

## Plugin Stack

### Core Plugins
- **lazy.nvim** - Plugin manager with lazy loading
- **nvim-lspconfig** - LSP client configuration
- **mason.nvim** - LSP server installer
- **nvim-treesitter** - Syntax highlighting and AST parsing

### Navigation & Search
- **telescope.nvim** - Fuzzy finder and search interface
- **telescope-fzf-native.nvim** - Fast native FZF sorting
- **telescope-live-grep-args.nvim** - Advanced grep with arguments
- **oil.nvim** - File browser and directory editor

### Development Tools
- **nvim-cmp** - Autocompletion engine
- **nvim-dap** - Debug Adapter Protocol client
- **none-ls.nvim** - Formatters and linters

### Git & Session Management
- **vim-fugitive** - Git integration
- **auto-session** - Automatic session management

### UI & Themes
- **gruvbox-material** - Color scheme
- **nvim-web-devicons** - File type icons

## Installation

### Prerequisites
```bash
# Required dependencies
sudo pacman -S neovim git ripgrep fd
# or on Ubuntu/Debian:
# sudo apt install neovim git ripgrep fd-find

# Optional but recommended
sudo pacman -S nodejs npm python python-pip
```

### Setup
```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone <your-repo> ~/.config/nvim
cd ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point, bootstraps lazy.nvim
├── lazy-lock.json          # Plugin version lockfile
├── myNvim/                 # Your customizations
│   ├── README.md           # This file
│   └── init.lua           # Alternative config
└── lua/
    ├── config/
    │   ├── options.lua     # Vim options and performance settings
    │   └── keymaps.lua     # All keybindings
    └── plugins/
        ├── completion.lua  # Autocompletion setup
        ├── copilot.lua    # GitHub Copilot config
        ├── debug.lua      # Debugging configuration
        ├── lsp.lua        # Language server setup
        ├── navigation.lua # File browser, git, sessions
        ├── telescope.lua  # Search and navigation
        ├── treesitter.lua # Syntax highlighting
        └── ui.lua         # Themes and UI components
```

## Keybindings Reference

### Leader Key
- Leader key: `<Space>`

### File Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `<C-p>` | Find files | Quick file finder |
| `<leader>ff` | Find files | Alternative file finder |
| `<leader>fg` | Live grep | Search text in files |
| `<leader>fG` | Advanced grep | Grep with filters and args |
| `<leader>fb` | Find buffers | Switch between open files |
| `<leader>fh` | Help tags | Search help documentation |
| `<leader>fr` | Recent files | Recently opened files |

### Symbol Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to symbol definition |
| `gD` | Go to declaration | Jump to symbol declaration |
| `gi` | Go to implementation | Jump to implementation |
| `gt` | Go to type definition | Jump to type definition |
| `gr` | Find references | Find all symbol references |
| `<leader>fs` | Document symbols | Symbols in current file |
| `<leader>fS` | Workspace symbols | Search symbols across project |
| `<leader>fi` | Implementations | Find implementations |
| `<leader>ft` | Type definitions | Find type definitions |

### LSP Actions
| Key | Action | Description |
|-----|--------|-------------|
| `K` | Hover documentation | Show symbol documentation |
| `<leader>rn` | Rename symbol | Rename across project |
| `<leader>ca` | Code actions | Show available actions |
| `<leader>gf` | Format code | Format current buffer |

### Diagnostics & Errors
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Show diagnostic | Show error/warning details |
| `[d` | Previous diagnostic | Jump to previous issue |
| `]d` | Next diagnostic | Jump to next issue |
| `<leader>D` | Previous error | Jump to previous error only |
| `<leader>d` | Next error | Jump to next error only |
| `<leader>q` | Diagnostic list | Open diagnostic quickfix |
| `<leader>wa` | Workspace diagnostics | All project diagnostics |

### File Browser
| Key | Action | Description |
|-----|--------|-------------|
| `<C-n>` | Open Oil | Open file browser |
| `<leader>-` | Parent directory | Open parent directory |

### Git Integration
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gs` | Git status | Open git status |
| `<leader>gb` | Git blame | Show git blame |
| `<leader>gl` | Git log | Show git log |

### Debugging
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>dt` | Toggle breakpoint | Set/remove breakpoint |
| `<leader>dc` | Continue | Continue debugging |

### Quick Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>w` | Save file | Write current buffer |
| `<leader>nh` | Clear highlights | Clear search highlights |

## Performance Optimizations

### Vim Options Applied
```lua
-- Performance optimizations for large codebases
vim.opt.updatetime = 100        -- Faster completion
vim.opt.timeoutlen = 300        -- Faster key sequences
vim.opt.redrawtime = 1500       -- Limit redraw time
vim.opt.synmaxcol = 240         -- Limit syntax highlighting width
vim.opt.lazyredraw = true       -- Don't redraw during macros
vim.opt.ttyfast = true          -- Fast terminal connection

-- Memory optimizations
vim.opt.hidden = true           -- Keep buffers in memory
vim.opt.backup = false          -- No backup files
vim.opt.writebackup = false     -- No backup during write
vim.opt.swapfile = false        -- No swap files
```

### File Ignore Patterns
The configuration automatically ignores:
- `node_modules/` - JavaScript dependencies
- `.git/` - Git metadata
- `dist/`, `build/`, `target/` - Build outputs
- `*.lock` - Lock files
- `*.min.js`, `*.min.css` - Minified files

### Lazy Loading
Plugins are configured to load only when needed:
- Treesitter loads on file open
- LSP loads when entering supported file types
- Telescope loads on first search command

## Language Support

### Supported Languages
| Language | LSP Server | Formatter | Linter |
|----------|------------|-----------|---------|
| Lua | lua_ls | stylua | - |
| Python | pyright | black, isort | ruff |
| JavaScript/TypeScript | ts_ls | prettier | eslint_d |
| Go | gopls | gofmt | - |
| Rust | rust_analyzer | rustfmt | - |
| C/C++ | clangd | clang-format | cppcheck |
| Ruby | - | rubocop | rubocop |
| SQL | - | - | - |
| Docker | dockerls | - | hadolint |
| Nix | nixd | nixpkgs_fmt | - |

### Adding New Languages
1. Add LSP server to `lua/plugins/lsp.lua`:
```lua
lspconfig.your_lsp.setup({})
```

2. Add treesitter parser to `lua/plugins/treesitter.lua`:
```lua
ensure_installed = {
  -- existing languages...
  "your_language",
}
```

3. Add formatters/linters to `lua/plugins/lsp.lua` in none-ls sources

## Advanced Usage

### Advanced Search with Live Grep Args

Use `<leader>fG` for powerful search capabilities:

#### File Type Filtering
```
searchterm --type=py          # Search only Python files
searchterm --type=js          # Search only JavaScript files
searchterm -t py -t js        # Search Python and JavaScript
```

#### Pattern Matching
```
searchterm --glob=*.config    # Search only .config files
searchterm --glob=!test*      # Exclude files starting with 'test'
searchterm --iglob=*.MD       # Case-insensitive glob
```

#### Search Options
```
searchterm --case-sensitive   # Case sensitive search
searchterm --word-regexp      # Match whole words only
searchterm --fixed-strings    # Literal string search
```

#### During Search
- `<C-k>` - Quote current input
- `<C-i>` - Add file type filter prompt

### Workspace Symbols Search

`<leader>fS` provides project-wide symbol search:
- Search for function names across all files
- Find class definitions in large codebases
- Locate variable declarations
- Fuzzy matching works for partial symbol names

### Session Management

Auto-session automatically:
- Saves your session when exiting Neovim
- Restores windows, buffers, and cursor positions
- Creates separate sessions per git branch
- Ignores common directories like Downloads

### Oil.nvim File Browser

Advanced file operations:
- Edit directories like regular buffers
- Rename files by editing text
- Create/delete files and directories
- Preview files with `<C-p>`
- Open in splits with `<C-s>` (vertical) or `<C-h>` (horizontal)

### Git Integration with Fugitive

Beyond basic commands:
- `:Gdiff` - View file changes
- `:Git log --oneline` - Compact log view
- `:Git checkout <branch>` - Switch branches
- Visual mode + `:Git add` - Stage selections

### LSP Features

#### Code Actions
`<leader>ca` provides context-aware actions:
- Auto-import missing modules
- Extract functions/variables
- Fix common errors
- Organize imports

#### Symbol Renaming
`<leader>rn` safely renames across:
- All references in current file
- All references in project
- Imports and exports
- Comments (language-dependent)

## Troubleshooting

### Common Issues

#### LSP Not Working
1. Check if language server is installed:
```bash
:Mason
```
2. Check LSP status:
```bash
:LspInfo
```
3. Restart LSP:
```bash
:LspRestart
```

#### Slow Performance
1. Check file ignore patterns in `telescope.lua`
2. Reduce treesitter languages if not needed
3. Check for large files causing issues:
```bash
:set synmaxcol=120  # Reduce syntax highlighting width
```

#### Telescope Not Finding Files
1. Ensure ripgrep is installed:
```bash
rg --version
```
2. Check if you're in a git repository (affects file searching)
3. Try manual grep:
```bash
:Telescope live_grep
```

#### Plugins Not Loading
1. Check lazy.nvim status:
```bash
:Lazy
```
2. Update plugins:
```bash
:Lazy sync
```
3. Check for errors:
```bash
:messages
```

### Performance Tuning

For very large codebases (>10k files):

1. Increase file limits in `telescope.lua`:
```lua
defaults = {
  file_ignore_patterns = {
    -- Add more patterns
    "vendor/",
    "%.min%.",
  }
}
```

2. Reduce treesitter languages to only what you use
3. Consider disabling auto-session for huge repositories
4. Use `:Telescope find_files hidden=false` to exclude hidden files

### Customization

#### Adding Custom Keybindings
Add to `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>custom", ":YourCommand<CR>", { desc = "Your description" })
```

#### Changing Color Scheme
Edit `init.lua`:
```lua
install = { colorscheme = { "your_colorscheme" } },
```

#### Adding New Plugins
Create new file in `lua/plugins/` or add to existing files:
```lua
return {
  {
    "author/plugin-name",
    config = function()
      -- Plugin configuration
    end,
  },
}
```