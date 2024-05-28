#!/bin/bash

# Usage: ./verify_password.sh <plain_password> <hashed_password>

plain_password=$1
hashed_password=$2

echo "Plain Password: $plain_password"
echo "Hashed Password: $hashed_password"

# Extract the salt from the hashed password
salt=$(echo $hashed_password | awk -F'$' '{print $3}')

echo "Salt: $salt"

# Hash the input password with the extracted salt
new_hashed_password=$(openssl passwd -6 -salt $salt $plain_password)

# Compare the new hash with the original hash
if [ "$new_hashed_password" == "$hashed_password" ]; then
    echo "Password is correct."
else
    echo "Password is incorrect."
fi
