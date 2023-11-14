#!/bin/bash

#the bash will exit the script immediately if  an error is encountered.
set -e

# if keyword is found
# grep -i ignore case; -q to be quiet 
if echo "$*" | grep -i -q FIXED;
then
    # do something
    echo "Found keyword."
# otherwise
else
    # exit gracefully
    echo "Nothing to process."
fi
