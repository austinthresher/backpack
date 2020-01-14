Backpack, a user space package manager
======================================

Backpack is a simple set of bash scripts that help automate building programs
from source. It's intended to be used as part of your dotfiles repo so that
specific versions of programs you use can easily be set up on multiple
computers.

Installation
------------

```
git clone https://github.com/austinthresher/backpack
cd backpack
./setup.sh
```

Add this line to your `.bashrc`:

```
source ~/.bpinit
```

Now you can install any of the scripts in the `packages` directory like:

```
bp_install neovim
```

Backpack will download and build neovim and its dependencies in
`$HOME/.backpack`. A script that sets necessary environment variables and then
runs the program will be in `$HOME/.backpack/bin`.

Package Scripts
---------------

While most of the install scripts in the `packages` directory have been tested
and work on Ubuntu 18.04, you may need to modify or add to them for your own
environment.

There are a number of bash functions available during script execution that
assist in common tasks:

	- `download <url>`
		- Downloads the file at <url> and places it into `$BACKPACK/tar/`
	- `extract`
		- Extracts the last archive downloaded with `download` into a
		  folder in `$BACKPACK/src/` with the name of the package
	- `link_to_root`
		- All packages are installed to individual directories, then
		  the contents of those directories are symlinked into
		  `$BACKPACK/bpfs/`. Additionally, any files located in the
		  `bin/` directory of the package are made callable from
		  `$BACKPACK/bin/`. This should be the last line of nearly
		  every package script.
	- `configure_flags`
		- Expands to the flags to pass to configure to install into
		  `$BACKPACK/pkg/<package-name>`. Any arguments passed to it
		  are appended to the output.
	- `cflags` and `ldflags`
	    	- Default values for CFLAGS and LDFLAGS, just like
		  `configure-flags`. Also takes additional arguments and
		  appends them.

In order to mark another package script as a prerequisite for the script
you're writing, just call `bp_install <package-name>` at the top of your
script. If it isn't installed, it will be, and if it is, it will just print
a message and continue.
