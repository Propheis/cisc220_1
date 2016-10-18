#!/bin/bash

function show_permission_diff() {
  echo "show"
}

function reset_permissions() {
  echo "reset"
}

if [[ $1 =~ ^\-s$ ]]; then
  show_permission_diff
elif [[ $1 =~ ^\-r$ ]]; then
  reset_permissions
else
  echo "Invalid arguments specified"
  echo "-s: show only, no action"
  echo "-r <filename>: reset to specified snapshot file specifications"
fi
