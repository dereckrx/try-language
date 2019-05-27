#!/usr/bin/env bash

set_result_to_param() {
    local result='my return value'
    local _return=$1
    eval ${_return}='"$result"'
}

set_global_result_var() {
    RESULT='my result value'
}

write_result_to_stdout() {
    local myresult='stdout value'
    echo "$myresult"
}

name_local_params() {
#  local org_calling_filename=$0
  local first_param=$1
  local all_params=$@
  echo "My first param is '$first_param'"
  echo "All my params are '$all_params'"
}

# ---
# Save return value to temp file
write_result_to_file() {
  local filename=$1
  local input=$2
  local result="<<<${input}>>>"
  echo "${result}" > "${filename}"
}

# Use local variable that is shared between functions but not global
# scope is restricted to the caller and the called function
rand() {
   local max=$((32768 / $1 * $1))
   while (( (roll=$RANDOM) >= max )); do : ; done
   roll=$(( roll % $1 ))
}

# Outside of this func at the global scope, 'roll' is not visible.
roll() {
   local roll
   rand 6
   echo "You rolled $((roll+1))!"
}