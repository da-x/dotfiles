#!/bin/sh
# courtesy of http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
# modified by https://github.com/richo/git_template/blob/master/hooks/ctags

echo bla > /tmp/xxx

mkdir .git/tags_lock 2>/dev/null || exit 0
trap "rmdir .git/tags_lock; rm -f .git/tags.$$" EXIT
git ls-files | ctags --c-kinds=+p --tag-relative -L - -f .git/tags.$$ --exclude=.git --languages=-sql,-css,-javascript
mv .git/tags.$$ .git/_TAGS_
