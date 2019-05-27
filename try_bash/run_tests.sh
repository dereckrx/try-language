#!/usr/bin/env bash

FILES=$(find ${ROOT_DIR} -type f -name '*_test.sh')

for file in ${FILES}; do
  echo "## Running ${file}"
  source ${file};
  echo
done