#!/bin/bash

GROUP="devteam"
USERS=("userA" "userB" "userC" "userD" "userE")

# Create group if not exists
if ! getent group $GROUP >/dev/null; then
  sudo groupadd $GROUP
  echo "Group $GROUP created."
else
  echo "Group $GROUP already exists."
fi

# Create users
for USER in "${USERS[@]}"; do
  if id "$USER" &>/dev/null; then
    echo "User $USER already exists."
  else
    sudo useradd -m -s /bin/bash -g $GROUP $USER
    echo "$USER:Password123" | sudo chpasswd
    sudo chage -d 0 $USER   # force password reset at next login
    echo "User $USER created and added to $GROUP."
  fi
done
