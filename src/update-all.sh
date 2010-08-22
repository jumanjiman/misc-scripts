#!/bin/bash

update_it() {
  git pull origin master
  git fetch origin --tags
}

repos="$(./find-gitrepos.sh ~)"
for repo in $repos; do
  echo =========================================================================
  pushd $repo
  master=$(git remote -v | awk -F@ '/origin/{print $2}' | cut -f1 -d:)
  [[ -n $master ]] || { popd; continue; } &> /dev/null
  reach $master || { popd; continue; } &> /dev/null
  update_it
  popd &> /dev/null
done
