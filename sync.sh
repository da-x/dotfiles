#!/bin/bash

set -eux

git fetch
git rebase

for i in dotzsh gdb-dashboard git-fixup ; do
    cd $i
    git submodule update --init --recursive --rebase
    cd ..
done

cd vimrc
vim -S snapshot.vim
