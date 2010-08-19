#!/bin/bash

# this script finds all subversion repos on a box
# and prints a list on stdout

# look for repos below $base_dir
# change base_dir to something else
# to limit the scope of the search
base_dir="/"

if [[ $(id -u) -ne 0 ]]; then
  echo "WARNING: You are not root, so this may not find everything" >&2
fi

is_svnrepo() {
  # returns 0 if $1 is a subversion repo
  # $1 should be path to directory
  _path=$1
  svnlook uuid $_path &> /dev/null
  return $?
}

hooks_dirs="$(find $base_dir -name hooks 2> /dev/null)"
for dir in $hooks_dirs; do
  repo="$(dirname $dir)"
  is_svnrepo $repo && echo $repo
done
