#!/usr/bin/env bash

# Building function libraries
# https://edmondscommerce.github.io/programming/linux/ubuntu/building-bash-function-libraries.html

set -o errexit # stop the script when an error occurs.
set -o pipefail # stop "error here | true" from succeeding
[[ "${DEBUG}" == 'true' ]] && set -o xtrace # print every expression before executing it if DEBUG

# List functions in the file with
# $ func parse.
# List all functions with 'log' in the name
# $ parse. log
parse.() { # auto complete helper, second argument is a grep against the function list
    if [[ '' == "$@" ]]
    then
        echo "Parse Namespaced Functions List"
        cat $BASH_SOURCE | grep "() {" | awk '{j=" USAGE:"; for (i=5; i<=NF; i++) j=j " "$i; print $2" "j}'
    else
        echo "Parse Functions Matching: $@"
        cat $BASH_SOURCE | grep "^function[^(]" | awk '{j=" USAGE:"; for (i=5; i<=NF; i++) j=j" "$i; print $2" "j}' | grep $@
    fi
}

parse.access_log_top_ten_code() { # Show the top ten code from access_log: useage ...code $FILE $CODE
	FILE=$1
	CODE=$2
	echo "Count the top ten $CODE'd pages"

	cat $FILE | awk '{ i=($9=="$CODE" ) ? $7 : ""; print i; }' | sort | uniq -c | sort -n | tail -n 11 | head -n 10
}

parse.