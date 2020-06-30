
# My Fundamental Unix Dotfiles

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

