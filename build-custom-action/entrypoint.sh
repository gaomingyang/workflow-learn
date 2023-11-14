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


# -n 检查字符串是否为空
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
    # echo "Found keyword."

    VERSION=$(date +%F.%s)

    DATA="$(printf '{"tag_name":"v%s",' $VERSION)"
    DATA="${DATA} $(printf '"target_commitish":"master",')"
    DATA="${DATA} $(printf '"name":"v%s",' $VERSION)"
    DATA="${DATA} $(printf '"body":"Automated release based on keyword: %s",' "$*")"
    DATA="${DATA} $(printf '"draft":false, "prerelease":false}')"

    URL="https://api.github.com/repos/${GITHUB_REPOSITORY}/releases?access_token=${GITHUB_TOKEN}"

    if [[ "${LOCAL_TEST}" == *"true"* ]];
    then
        echo "## [TESTING] Keyword was found but no release was created."
    else
        echo $DATA | http POST $URL | jq .
    fi

# otherwise
else
    # exit gracefully
    echo "Nothing to process."
fi