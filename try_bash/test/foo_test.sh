#!/usr/bin/env bash

#source ${ROOT_DIR}/test/test_helper.sh
#source ${ROOT_DIR}/foo.sh

test.foo() {
  local my_dir=$( dirname "${BASH_SOURCE[0]}" )

  source "${my_dir}/test_helper.sh"
  source "${my_dir}/../foo.sh"

  # `echo test` is expected to write "test" on stdout
  assert "echo test" "test"
  # `seq 3` is expected to print "1", "2" and "3" on different lines
  assert "seq 3" "1\n2\n3"
  # exit code of `true` is expected to be 0
  assert_raises "true"
  # exit code of `false` is expected to be 1
  assert_raises "false" 1

  # end of test suite
  assert_end "'${BASH_SOURCE[0]}'"
} && test.foo