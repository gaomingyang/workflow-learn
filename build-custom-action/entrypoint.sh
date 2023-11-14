#!/bin/bash

#the bash will exit the script immediately if  an error is encountered.
set -e

# # if keyword is found
# # grep -i ignore case; -q to be quiet 
# if echo "$*" | grep -i -q FIXED;
# then
#     # do something
#     echo "Found keyword."
# # otherwise
# else
#     # exit gracefully
#     echo "Nothing to process."
# fi



if [ -n "$GITHUB_EVENT_PATH" ];
then
    EVENT_PATH=$GITHUB_EVENT_PATH
elif [ -f ./sample_push_event.json ];
then
    EVENT_PATH='./sample_push_event.json'
    LOCAL_TEST=true
else
    echo "No JSON data to process! :("
    exit 1
fi

env
jq . < $EVENT_PATH

# if keyword is found
if jq '.commits[].message, .head_commit.message' < $EVENT_PATH | grep -i -q "$*";
then
    # do something
    echo "Found keyword."
# otherwise
else
    # exit gracefully
    echo "Nothing to process."
fi