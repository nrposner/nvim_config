Guide to setting up a tmux+nvim config, pulling liberally from DevOps Toolbox and typcraft.

**Step 0 (optional): Terminal Installation**
For best results, download a terminal like iTerm2 instead of using the default shell. In addition, download a [Nerd Font](https://www.nerdfonts.com/font-downloads).
I use MesloLGL Nerd Font Mono, but any monspaced font that supports vim devicons will work. 

**Step 1: Neovim installation**
Use `brew install neovim` or your package manager of choice on your platform of choice. 

Basics to cover: 
  What is Neovim?
  Vim motion keys, yanking, deleting, pasting, searching, macros, command line

**Step 2: Neovim Setup**
Let's create a basic file structure we'll be coming back to. In your `~/.config` directory, create a `nvim` directory. Inside `nvim`, create the following:
  a file, `~/.config/nvim/init.lua`
  A directory, `~/.config/nvim/lua`

Inside ~/.config/nvim/lua, further, create a `plugins` directory. Within `plugins`, create a single file, `placeholder.lua`, with a single line of code: `return {}`.

Congratulations! This is all the directory setup you'll need for Neovim. 

_Why do we do all this?_
By default, the Neovim runtime checks this location, `/.config/` for an `nvim` directory to set up its environment. 
It also defaults to searching for an `init.lua` file for the top-level customization, and searches for a `nvim/lua` directory for more detailed setup information. 
By creating this filetree, we've set ourselves up for success, as our customization will now be well-organized and compatible with Neovim's default assumptions!

_What is lua?_
Lua is a popular and powerful scripting language which we can use to customize Neovim. You don't need to be a master of lua, or even a basic user, in order to use Neovim. Even so, you'll acquire some basic understanding of how it works in the course of this tutorial.

Now that we're set up, let's copy a few files in. Copy the contents of `init.lua` from this directory into your file of the same name. 
Let's look at what we have in here for a moment. A lot of these commands are down to personal convenience and taste. 
For example, `vim.g.mapleader` sets the 'leader' key, which is used for a lot of custom commands. By default, this is set to `/` backslash, but I prefer to use the spacebar. 
Others, like the `vim.cmd("set ...")` commands set personal preferences around tab/space length, while the and vim.cmd("abb ...") lines tell Neovim to automatically correct strings like 'hte' to 'the', because I often misspell that and don't want to bother with corecting myself over and over again. 
The vim.opt lines, meanwhile, set certain useful options that are off by default. number and relative number make the line numbers visible and make them relative to the current line (very useful when you're jumping around the screen with vim commands!). The most useful of these by far, virtually a necessity, is vim.opt.clipboard = "unnamedplus". This allows us to automatically copy anything we yank into the system clipboard.

But some of these are quite important. At the bottom, you'll see a lengthier chunk detailing `/lazy/lazy.nvim`. Below that, you'll see the lines `vim.opt.rtp:prepend(lazypath)` and `require("lazy").setup("plugins")` What are these?

**Step 3. LazyVim**
LazyVim is a very popular and higly performant package manager for Neovim. It's virtues are many, but all you need to know right now is that LazyVim is your all-in-one package manager, like pip for Python or npm for nodeJS. Developers of Neovim plugins target LazyVim (as well as other distributors like LunarVim) in order to make your experience of installing and using plugins quick and easy. 
(LazyVim, like all the other software we discuss in this tutorial, is completely free and open source, with support from a community of passionate and dedicated mainainers. When you find a tool that is valuable to you, consider going to their [repos](https://github.com/LazyVim/LazyVim) and giving them a GitHub star!)
Also, LazyVim has a kickass UI.

The snippet we mentioned above performs a simple task: it checks to see whether LazyVim is installed. If it is not, it will access the internet and clones LazyVim from the latest stable branch of the GitHub repository. Once this runs the first time, exit and restart Neovim (as simple as using :q and nvim .) and you should see LazyVim start up!

What about the other two lines?

The line about vim.opt tells Neovim to take into accout the options that we defined earlier. Otherwise, they wouldn't get saved and used!

The last line of code, about lazy setup, tells LazyVim that it requires the contents of the `plugins` directory in order to complete setup. That's why we created the directory ahead of time and made a file that returns an empty table. 

Now when you open Neovim, things should look quite different. You can also open the internal command line (using `:`) and enter `Lazy` in order to see the LazyVim dashboard. 

With this, we can now get to the fun stuff. 

**Step 4: Fortification and Beautification with Neovim Plugins**
The default LazyVim experience, like the original Neovim experience, is still quite bare-bones and has a rather poor color scheme. So we're going to install some plugins. 

Package installation in other domains can be stressful, but not so with LazyVim. Thanks to the setup we have here, installing a new plugin is as simple as making a new file in `plugins`, adding a snippet of code, saving the file, and reopening Neovim. All you need is an internet connection!

In the repo here, you'll find quite a number of plugin files. These represent my own current Neovim setup, and many of them won't be relevant to you (though if you want to steal my look 100%, you are of course welcome). 

Instead, I'll enumerate the plugins from most essential to most niche. 

_colors.lua_
Though not strictly functional, this is probably the first plugin you should install. 
This file installs the catppuccin plugin, which is a beatiful colorscheme that makes working in the terminal much easier on the eyes. 
You'll also find commented code to use a different color scheme, tokyo-night. I go back and forth between them: I prefer tokyo-night's text colors, but catppuccin's color selection otherwise. You can switch between them as easily as commenting out one, uncommenting the other, saving the file, and reopening neovim. Switch between them and see what you like best!

_lazygit.lua_
A powerful interface for managing Git from inside Neovim.
After several months with it, it's my go-to: I can quickly get an overview of all commits, branches, edited/added/staged files, and do just about anything else I need. Partial commits? Patching individual lines? Quickly and easily resolving merge conflicts? Does it all, right from the terminal. I never need to leave Neovim to handle my git. 
Check out the creator's [guide](https://www.youtube.com/watch?v=CPLdltN7wgE) for a... not really beginner friendly primer. I'd say a more accessible introduction would be called for, but you're setting up an internal Git interface for Neovim, you're not a beginner. You'll be fine. 

_neotree.lua_
This one allows you to access more than just a single file at a time. Instead, you can navigate your whole filetree from inside neovim, as if it were a full IDE! 
There's a ton of mappings and options here, and you can customize these to taste. My defaults use the home-row keys to navigate the files a la Vim: use j and k to move up and down, and l to open folders and files. You can also use Esc at the topmost line to move into the higher directory. 
I also have <leader>o bound to open the filetree and <leader>c to close it. If the filetree is already open, you can use the open command to move into it!
Do also check out what I've set to the symbols for file changes, deletions, etc. If you don't quite like, for example, that a pencil marks renamed files and a dotted box marks unstaged files, change these to your preference! Any and all Unicode characters work.  

_telescope.lua_
Just about every Neovim tutorial out there will recommend installing Telescope. It's a blazing fast fuzzy finder that can operate very quickly over large codebases. 
Right now, I'm only using it for two things: searching for file names, and grepping through the files themselves for function names and keywords. I have these bound to <leader>t and <leader>g respectively, short for 'telescope' and 'grep'!
Whenever you're working through a large codebase, these Telescope functionalities will be lifesavers!

_treesitter.lua_
Not to be confused with `neo-tree`, this is the quiet workhorse of Neovim plugins. 
It generates an abstract syntax tree from your code in order to support highlighting and indenting. 
You won't spend much time using it directly, but lots of other plugins you want will require it. 

_mason.lua_
The two plugins in here leverage Mason, a configuration manager for LSPs, linters, formatters, and more. 
What is an LSP? A linter? A DAP server? I installed Mason in order to never ask those questions again. Long story short, it lets you do fun stuff like autocomplete, syntax checking, and definitions of built-in objects for your language of choice.
Note that, at present, I only use the LSP for Rust, `rust-analyzer`. If you want to use other languages, it's as simple as changing that line and adding them into the ensure_installed table. For example, if you wanted to drop rust and use Java, you'd change `ensure_installed = { "rust_analyzer" }` into `ensure_installed = { "jdtls"}`. 

_gitsigns.lua_
This is a must-have if you work within a git repository. 
Whenever you add, change, or delete lines in a git repo, this plugin will add lines in the margin which will show exactly where the change was made and which kind of change it was. 
Actually, it's a good deal more powerful than that, but I mainly use it for the gutter lines. 

_harpoon.lua_
Hop between up to 4 commonly-visited files in a repository like a roadrunner on cocaine.
The Primeagen's very own Neovim plugin. If you find yourself constantly tabbing between the same 2-4 files, harpoon is for you.

_autopairs.lua_
An essential quality-of-life pair completion plugin.
Install it, forget about it, and never get frustrated by braces again. 

_noice.lua_
From the creator of LazyVim, a new, enhanced UI for LazyVim. 
This is mainly a visual enhancement, but it's a great one, making the whol experience a good deal friendlier. 

_blink.lua_
A very nice plugin for autocomplete and showing signatures. 
The default uses enter-completion for auto-suggestions, but my implementation here uses tab-completion, because I'm not a monster. Do also note the ctrl+k keybind that lets you see the signature for any object your cursor is on!

_lualine.lua_
Like `colors` and `noice`, this is mainly visual, but highly, highly recommended. This changes the bottom of your screen into a customizable status bar that can show you just about anything you want. 
It works especially well in conjunction with noice, and is practically made for tmux (which we'll get into in the next section). My implementation here puts several objects on the status bar, some of them hidden until certain conditions arise:
Namely, I have Neovim mode (so you always know whether you're in normal mode, inserting, visual, or command), a git branch label, a language icon and filepath, counts of errors, warnings, and suggestions, number of lines added or deleted, cursor position on row:column, and percent-progress in the file. 
As you can see from the commented code, I used to have a clock as well, but I got rid of it because tmux had the same functionality. Customize this as suits your needs!

_snacks.lua_
A curated collection of quality-of-life improvements, once again from the creator of LazyVim. Mainly invisible changes for things like handling large files, nicer notifications, improved scrolling, and so on. A must-have.

_flash.lua_
Quickly jump around text on your screen.
This takes a little getting used to, but feels so nice once you do. I've only begun to tap into what it can do.

_whichkey.lua_
A neat little helper in case you forget vim motions or your own keybinds. If you're part way through a command that hasn't executed yet and you don't type for a short period, it'll bring up a menu of possible commands to follow. If you use your leader key, it'll bring up the keybinds you defined which use it!
My implementation has a slightly longer delay time than default, 300 milliseconds instead of 200. I just felt like the default was a little too trigger-happy. Customize to taste!

_trouble.lua_
An enhanced bug and error display system. Includes several keybinds for different levels of observability into whatever trouble the code is causing you. 
I don't use this too much myself, since I have a lot of the same inline diagnostics keyed to <leader>e. But nice to have nonetheless!

_rustacean.lua_
If you program in Rust, this is a must-have collection of plugins for the language. Don't leave home without it. 
If you don't use Rust however, it'll just weigh you down. 

_jupytext.lua_
If you're in the unenviable position of spending a nontrivial amount of your time working with Jupyter notebooks, you'll quickly get very, very tired of either having to tab into another IDE or edit raw JSON. With Jupytext, you get a good-looking view into notebooks and can edit them like markdown. If youv'e used R Markdown files, it'll be familiar. 
Note that this doesn't allow you to *run* Jupyter notebooks. Other plugins exist for that, but I haven't tested them out yet. 

_nvim-surround.lua_
A plugin extending Vim's motions to allow for easy surrounding. 
The functionality is great, but using it will take a little practice. Check out the [repo](https://github.com/kylechui/nvim-surround) for a guide. Getting good at this will take out a lot of little pains. 




## Step 5: tmux Installation
tmux is a multiplexer terminal and an effective platform for further customizing your terminal experience. 

My own tmux config is not very sophisticated, and is primarily based on this [video](https://www.youtube.com/watch?v=GH3kpsbbERo). It will take you from installation through basic use and recommended plugins. 

Among the most useful plugins described in that video is tmux-catppuccin, which really brings together the look of the terminal in combination with a catppuccin theme for Neovim. It also includes a very nice-looking upper status bar which nicely complements a Neovim lualine. 

I also personally recommend changing the default tmux prefix from Ctrl+B to something friendlier. Personally, I use Ctrl+A, which makes switching windows nice and fluid. Other useful changes mentioned in the video include indexing windows from 1 instead of 0 and allowing navigation in terminal output using Vim motions. 
