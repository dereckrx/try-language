#!/usr/bin/env bash

source ${ROOT_DIR}/test/test_helper.sh
source ${ROOT_DIR}/functions.sh

# TEST function sets a return param with result"
set_result_to_param func_result
assert_equal "${func_result}" "my return value"

# TEST function sets result global variable
set_global_result_var
assert_equal "${RESULT}" "my result value"

# TEST function returns value via stdout
result=$(write_result_to_stdout)
assert_equal "${result}" "stdout value"

# TEST function with params
result=$(name_local_params foo bar)
assert 'echo ${result}' "My first param is 'foo' All my params are 'foo bar'"

# TEST writing result to file
tmpfile="tmp/return_value.txt"
write_result_to_file ${tmpfile} "foo"
assert 'echo $(<"$tmpfile")' "<<<foo>>>"

result=$(roll)
assert 'echo ${result} | grep -o "You rolled"' "You rolled"
assert_contains "${result}" "You rolled"

assert_end "'${BASH_SOURCE[0]}'"
