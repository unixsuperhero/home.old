
# My Fundamental Unix Dotfiles

## TO DO ##

** Add shalarm to this repo, because i found a good cli alarm clock...and it's
very basic...just a shell script and a wav file so i will probably just steal
and remodel it **

* `git clone https://github.com/jahendrie/shalarm`

## Goals

* make this repo super modular
  * not all settings are needed all the time, so allow the user to pick and
    choose

## Notes

* it is assumed that these files will end up in your home directory, so the
  paths will be relative to: `~/`, `$HOME/`, etc.  Take your pick.

## Plans (If not implemented yet...)

* readline settings (`.inputrc`)
* shell settings:
  * bash
    * `.bashrc`
      * `bash/git.bashrc` which will probably source files deeper in the tree:
        * `bash/git/log.bashrc`
        * `bash/git/commit.bashrc`
        * `bash/git/fetch.bashrc`
        * `bash/git/pull.bashrc`
        * `bash/git/merge.bashrc`
        * **NOTICE:** that you don't see `bash/git/aliases.bashrc`, this is
          because each of the above files will require a combination of aliases,
          functions, etc. to fully implement features.  it would be more
          disjointed if i source files based on the types of options they are,
          rather than the types of features they enhance.
  * zsh
    * `.zshrc`
      * `zsh/git.zshrc` which will probably source files deeper in the tree:
        * `zsh/git/log.zshrc`

* etc...


# Tutorials

** Add a tutorials section for command-line tips and tricks that I tend to
forget about over time. **

* see: `tutorials/README.md`


