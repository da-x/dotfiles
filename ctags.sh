#!/bin/sh
# courtesy of http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
# modified by https://github.com/richo/git_template/blob/master/hooks/ctags

mkdir .git/tags_lock 2>/dev/null || exit 0
trap "rmdir .git/tags_lock; rm -f .git/tags.$$" EXIT
grep '^/._TAGS_' .git/info/exclude > /dev/null
if [[ $? != 0 ]] ; then
    echo /._TAGS_ >> .git/info/exclude
fi
git ls-files | ctags --c-kinds=+p -L - -f .git/tags.$$ --exclude=.git --languages=-sql,-css,-javascript
mv .git/tags.$$ ._TAGS_
