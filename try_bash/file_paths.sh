#!/usr/bin/env bash
# https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself

readonly mydir1="${0%/*}"
readonly mydir2=$(dirname "$0")
readonly mydir3="$(dirname "$(readlink "$0")")"
### WINNER
readonly mydir4="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly mydir5=$( dirname "${BASH_SOURCE[0]}" )

echo "1 0%/* => $mydir1"
echo "2 dirname 0 => $mydir2"
echo "3 dirname + readlink => $mydir3"
echo "4 BASH_SOURCE => $mydir4"
echo "5 dirname BS => ${mydir5}"

#---
echo "1"
source "$mydir1"/../try_bash/deps/assert.sh
source "$mydir1"/../try_bash/test/foo_test.sh
source "$mydir1"/../try_bash/foo.sh

echo "2"
source "$mydir2"/../try_bash/deps/assert.sh
source "$mydir2"/../try_bash/test/foo_test.sh
source "$mydir2"/../try_bash/foo.sh

echo "3 bad"
source "$mydir3"/../try_bash/deps/assert.sh
source "$mydir3"/../try_bash/test/foo_test.sh
source "$mydir3"/../try_bash/foo.sh

echo "4"
source "$mydir4"/../try_bash/deps/assert.sh
source "$mydir4"/../try_bash/test/foo_test.sh
source "$mydir4"/../try_bash/foo.sh

echo "5"
source "$mydir5"/../try_bash/deps/assert.sh
source "$mydir5"/../try_bash/test/foo_test.sh
source "$mydir5"/../try_bash/foo.sh