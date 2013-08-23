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

%w[ackrc bash_profile bashrc gitconfig gitignore].each do |file|
  install(file)
end

if File.exists?("/usr/local/etc/bash_completion.d/git-completion.bash")
  dot_file = File.expand_path("~/.git-completion.bash")
  FileUtils.rm(dot_file) if File.exists?(dot_file)
  File.symlink("/usr/local/etc/bash_completion.d/git-completion.bash", dot_file)
end
