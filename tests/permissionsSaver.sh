#!/bin/bash


#
# Kevin Zuern   - 10134425
# Deven Bernard - 10099810
# Marissa Huang - 10179169
#


function snapshot_permissions() {
  traverse_all_child_files
}

########################################
########################################
########################################

function getFileName() {
  snapshotNumber=""

  if [ ! -f $(pwd)/savedPermissions ]; then
    touch savedPermissions
  else
    snapshotNumber="$(find savedPermissions* | wc -l )"
  fi

  echo "savedPermissions$snapshotNumber"
}

function traverse_all_child_files() {
  # find all child files & dirs
  find $(pwd) | while read file; do
    ls -al $file | awk '{print $1 " " $9}' >> .permissionsTemp
  done

  savedPermissions="$(getFileName)"

  while read entry; do
    
    if [[  $entry =~ ^.{10}\ \/.*                 # Only absolute paths
        && ! $entry =~ total                      # Ignore total files in dir line
        && ! $entry =~ ^.{10}\ \.\.?              # Ignore parent dirs
        && ! $entry =~ permissionsSaver
        && ! $entry =~ permissionsResetter
        && ! $entry =~ savedPermissions ]]; then
      echo $entry >> $savedPermissions
    fi
  
  done <.permissionsTemp

  rm .permissionsTemp
  cat $savedPermissions

}

snapshot_permissions
echo "All done!"