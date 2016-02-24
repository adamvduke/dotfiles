#! /usr/bin/env ruby
require "fileutils"

DIRECTORY = File.join(File.expand_path(File.dirname(__FILE__)), "/")

def install(original_file)
  dot_file = File.expand_path("~/.#{original_file}")
  if (File.exists?(dot_file) && !File.symlink?(dot_file))
    FileUtils.mv(dot_file, DIRECTORY + "backup/#{original_file}.bak")
  end
  FileUtils.rm(dot_file) if File.exists?(dot_file)
  File.symlink(File.expand_path(DIRECTORY + original_file), dot_file)
end

%w[ackrc bash_profile bashrc bashrc.local gemrc gitconfig gitignore tmux.conf].each do |file|
  install(file)
end
