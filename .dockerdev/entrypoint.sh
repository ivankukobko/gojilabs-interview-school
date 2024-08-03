#!/usr/bin/env sh

ruby -v
bundle install -j4 --retry 6
yarn install --no-optional --pure-lockfile

echo 'Running your scripts... '
$@
echo 'Done.'
