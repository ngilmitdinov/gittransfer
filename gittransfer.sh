#!/bin/bash

set -x

PRIVATE_TOKEN='xxxxxxxxx_XXXXXXX' #you can get in admin area of source gitlab
REPO_COUNT=100 #maybe greater
SRC_GIT="srcgitlab.domain1.ru"
DEST_GIT="destgitlab.domain2.net"
REPO_GROUP="dotnet"

for i in $(curl --header "Private-Token: $PRIVATE_TOKEN"  "https://$SRC_GIT/api/v4/projects?page=1&per_page=$REPO_COUNT" |  python -m json.tool | grep path_with_namespace | awk '{print $2}' | sed 's|"||g' | sed 's|,||g')
do
  REPO_NAME=$(echo $i | sed 's|.*/||')
  if [ $(echo $i | grep $REPO_GROUP) ]; then 
    REPO_PATH=$REPO_GROUP/$REPO_NAME
    echo $REPO_PATH
    git clone --bare git@$SRC_GIT:$REPO_PATH.git "$REPO_PATH" # && \
    cd $REPO_PATH && git remote add new-origin ssh://git@$DEST_GIT/$REPO_GROUP/$REPO_NAME.git && git push -u new-origin --all && \
    cd - && rm -rf $REPO_GROUP && \
    echo 'This repo transfered!'
  fi;
done
