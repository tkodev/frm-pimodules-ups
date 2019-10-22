#!/bin/bash

# sudo access check
  echo "[sudo access check]"
  if [[ $(sudo whoami) == "root" ]]; then
    echo "sudo access granted."
  else
    echo "sudo access denied."
    exit 1
  fi
  echo
