#!/bin/bash

WORKDIR="${1:-public}"

echo "Generating env file..."
echo "provided workdir path $WORKDIR"

# Recreate config file
rm -rf $WORKDIR/env-config.js
touch $WORKDIR/env-config.js

# Add assignment 
echo "window.__ENV = {" >> $WORKDIR/env-config.js

# Read each line in .env file
# Each line represents key=value pairs
while read -r line || [[ -n "$line" ]];
do
  # Split env variables by character `=`
  if printf '%s\n' "$line" | grep -q -e '='; then
    varname=$(printf '%s\n' "$line" | sed -e 's/=.*//')
    varvalue=$(printf '%s\n' "$line" | sed -e 's/^[^=]*=//')
  fi

  # Read value of current variable if exists as Environment variable
  value=$(printf '%s\n' "${!varname}")
  # Otherwise use value from .env file
  [[ -z $value ]] && value=${varvalue}
  
  # Append configuration property to JS file
  echo "  $varname: \"$value\"," >> $WORKDIR/env-config.js
done < $WORKDIR/.env

echo "}" >> $WORKDIR/env-config.js
echo "Test Generating env file... -> DONE"