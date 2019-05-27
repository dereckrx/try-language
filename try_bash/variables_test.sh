#!/usr/bin/env bash

source "${ROOT_DIR}/test/test_helper.sh"

test.variables() {

  readonly local variable="foo"

  # string interpolation:
  assert_equal "${variable}.yml" "foo.yml"

  # string replacement: //from/to
  assert_equal "${variable//oo/ur}" "fur"

  #default/fallback values: :-default
  assert_equal "${undefined:-something_else}" "something_else"

  assert_end "'${BASH_SOURCE[0]}'"
} && test.variables



