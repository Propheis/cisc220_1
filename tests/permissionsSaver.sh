#!/bin/bash


#
# Kevin Zuern   - 10134425
# Deven Bernard - 10099810
# Marissa Huang - 10179169
#


function show_help() {
  echo "help"
}

function show_permission_diff() {
  echo "show"
}

function reset_permissions() {
  echo "reset"
}

function snapshot_permissions() {
  traverse_all_child_files
}

########################################
########################################
########################################

function getFileName() {
  snapshotNumber=""

  if [ ! -f "$(pwd)/snapshotNumber" ]; then
    echo "hi"
    touch savedPermissions
  else
    snapshotNumber="$(find savedPermissions* | wc -l )"
    echo $snapshotNumber
  fi

  # get the new number to append to our filename
  

  echo "savedPermissions$snapshotNumber"
  #echo "savedPermissions1"
}

function traverse_all_child_files() {
  # find all child files & dirs
  find $(pwd) | while read file; do
    ls -al $file | awk '{print $1 " " $9}' >> .permissionsTemp
  done

  savedPermissions="$(getFileName)"

  while read entry; do
    
    if [[ ! $entry =~ \t\o\t\a\l ]] && [[ ! $entry =~ ^.{10}\ \.\.? ]]; then
      echo $entry >> $savedPermissions  
    fi
  
  done <.permissionsTemp

  rm .permissionsTemp
  cat $savedPermissions

}

########################################
########################################
########################################

if [[ $1 =~ ^\-s$ ]]; then
  show_permission_diff
elif [[ $1 =~ ^\-r$ ]]; then
  reset_permissions
elif [[ $1 =~ (^\-\-help$)|(^\-h$) ]]; then
  show_help
elif [[ $1 =~ '' ]]; then
  #snapshot_permissions
  echo $(getFileName)
else
  echo "Invalid arguments specified"
  show_help
fi
