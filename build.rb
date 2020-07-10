#!/usr/bin/env ruby

require "pry"
require "./file_compiler"

include FileBuilder

bashrc do

  incl 'bash/settings/disable-ctrl_s-and-ctrl_q.bashrc'

  incl 'bash/rbenv.bashrc'

  incl 'bash/git/aliases_and_helper_functions.bashrc'
end

