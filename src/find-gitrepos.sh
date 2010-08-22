#!/bin/bash

# this script finds all git repos on a box
# and prints a list on stdout

# look for repos below $base_dir
# change base_dir to something else
# to limit the scope of the search
base_dir="${1-/}"
echo "Starting search at $base_dir" >&2

if [[ $(id -u) -ne 0 ]]; then
  echo "WARNING: You are not root, so this may not find everything" >&2
fi

is_gitrepo() {
  # returns 0 if $1 is a git repo
  # $1 should be path to directory
  _path=$1
  {
  pushd $_path
  git tag
  _rc=$?
  popd
  } &> /dev/null
  return $_rc
}

git_dirs="$(find $base_dir -type d -name .git 2> /dev/null)"
for dir in $git_dirs; do
  repo="$(dirname $dir)"
  is_gitrepo $repo && echo $repo
done
