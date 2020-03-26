#!/bin/bash

BUILD_NUMBER=$(Build.BuildNumber)

REVISION_NUMBER=$(Release.AttemptNumber)

RELEASE_ID=$(Release.ReleaseId)

echo "Build number to deploy as image on task 2 $BUILD_NUMBER with release number $REVISION_NUMBER  and release id $RELEASE_ID"

cd $(work.dir)

pwd

DOCKER_BUILD_NO="$BUILD_NUMBER-$REVISION_NUMBER"

echo "DOCKER_BUILD_NO is $DOCKER_BUILD_NO"

sudo docker build -t vighadev:$DOCKER_BUILD_NO .

sudo echo $(cat kubernatesDS.yaml | sudo awk '/image:/ {print $2}') > $(misc.dir)/old_docker_dev

sudo docker tag vighadev:$DOCKER_BUILD_NO  vigha.azurecr.io/vighadev:$DOCKER_BUILD_NO

sudo cat pass | sudo docker login -u vigha --password-stdin vigha.azurecr.io

sudo docker push vigha.azurecr.io/vighadev:$DOCKER_BUILD_NO 

#Replacing the image name with newly pushed docker image 
sudo sed -i "s/vighadev:.*/vighadev:$DOCKER_BUILD_NO /g" kubernatesDS.yaml

