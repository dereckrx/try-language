#!/usr/bin/env bash

source ${ROOT_DIR}/test/test_helper.sh

if [[ -f $file1 && ( -d $dir1 || -d $dir2 ) ]]; then
  echo ""
fi

if [[ "${var}" -le 0 ]]; then
  echo "true"
fi

assert_end "'${BASH_SOURCE[0]}'"
