#!/usr/bin/env ruby

require "pry"
require "./file_compiler"

include FileCompiler

incl 'bash/settings/disable-ctrl_s-and-ctrl_q.bashrc'

save

