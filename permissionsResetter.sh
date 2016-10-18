#!/bin/bash

function show_permission_diff() {
  ./permissionsSaver.sh > /dev/null # run without any output to user

  # Get the last savedPermissions and the one we just made and diff them
  find savedPermissions* | sort -r | head -n 2 | xargs -n2 diff

  # Maybe use that to pull out the old and new file permissions, OR
  # you could go through each file line by line and compare the permissions,
  # but that may get hairy if new files were created in the meantime, messing
  # up the line pairings. Idk :P 
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
