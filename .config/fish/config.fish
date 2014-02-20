#!/usr/local/bin/fish
set -gx PATH $HOME/.pythonbrew/pythons/**/bin/ $PATH
set -gx PATH ./node_modules/.bin $PATH
set -gx PATH (brew --prefix)/opt/python/bin $PATH
set -gx PATH $HOME/bin $PATH
set -gx PATH $HOME/scripts $PATH
set -gx PATH /Applications/Postgres93.app/Contents/MacOS/bin $PATH

set -gx EDITOR emacs
set -gx BUNDLER_EDITOR subl

set fish_theme agnoster
set fish_plugins autojump bundler rvm brew rails sublime

sh ~/.env

function gs
  git status
end

function fish_title
  basename (pwd)
end

function export
  set arr (echo $argv|tr = \n)
  echo $arr[1]
  echo $arr[2]
  set -Ux $arr[1] $arr[2]
end

function __check_rvm --on-variable PWD --description 'Do rvm stuff'
  status --is-command-substitution; and return

  if test -f .ruby-gemset -a -f .ruby-version
  	rvm use (cat .ruby-version)@(cat .ruby-gemset) --create
  end
end

__check_rvm
