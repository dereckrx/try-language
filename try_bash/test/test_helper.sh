#!/usr/bin/env bash

my_dir=$( dirname "${BASH_SOURCE[0]}" )
#source ${ROOT_DIR}/deps/assert.sh
source ${my_dir}/../deps/assert.sh

assert_equal() {
  local result=$1
  local expected=$2
  assert "echo ${1}" "${2}"
}

assert_contains() {
  local result=$1
  local substr=$2
  assert 'echo ${result} | grep -o "${substr}"' "${substr}"
}