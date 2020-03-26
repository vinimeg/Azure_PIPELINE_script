#!/bin/bash

BUILD_NUMBER=$(Build.BuildNumber)

REVISION_NUMBER=$(Release.AttemptNumber)

echo "Build number to deploy as image on task 2 $BUILD_NUMBER with release number $REVISION_NUMBER"

cd $(work.dir)

pwd

DOCKER_BUILD_NO="$BUILD_NUMBER-$REVISION_NUMBER"

echo "DOCKER_BUILD_NO is $DOCKER_BUILD_NO"

sudo docker build -t vighauat:$DOCKER_BUILD_NO .

sudo echo $(cat kubernatesDS.yaml | sudo awk '/image:/ {print $2}') > $(misc.dir)/old_docker_dev

sudo docker tag vighauat:$DOCKER_BUILD_NO  vigha.azurecr.io/vighauat:$DOCKER_BUILD_NO

sudo cat pass | sudo docker login -u vigha --password-stdin vigha.azurecr.io

sudo docker push vigha.azurecr.io/vighauat:$DOCKER_BUILD_NO 

#Replacing the image name with newly pushed docker image 
sudo sed -i "s/vighauat:.*/vighauat:$DOCKER_BUILD_NO /g" kubernatesDS.yaml

