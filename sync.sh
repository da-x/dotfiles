#!/bin/bash

set -eux

git fetch
git rebase
git submodule update --init --recursive --rebase
