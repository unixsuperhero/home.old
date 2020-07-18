
# My Fundamental Unix Dotfiles

## TO DO ##

** Add shalarm to this repo, because i found a good cli alarm clock...and it's
very basic...just a shell script and a wav file so i will probably just steal
and remodel it **

* `git clone https://github.com/jahendrie/shalarm`

* **USE YAML TO DEFINE WHAT FILES TO INCLUDE IN FINAL FILE**
  * Possibly setup a bash script with a bunch of:
    * `cat bash/git/log.bashrc`
    * `cat bash/git/commit.bashrc`
    * `cat bash/git/fetch.bashrc`
  * ...instead of the ruby build.rb script.

  * Maybe have different dotfile builders, in case we automatically add comments
    to the final file, we can make sure we don't get any syntax errors
  ```
  bashrc do |f|
    f.incl 'bash/rbenv.bashrc'
  end

  # THIS IS ACTUALLY SO MUCH NICER
  # it's just a function that takes a block and when the block is processed the
  # incl or whatever methods will read in the files, but the nice part is, at
  # the end of processing the block (1 LOC) we can save the file right away,
  # instead of having to call .save manually
  ```

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


