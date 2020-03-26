#!/bin/bash

BUILD_NUMBER=$(Build.BuildNumber)

WAR_NAME="azure-$BUILD_NUMBER.war"

echo "WAR_NAME name $WAR_NAME"

ARTIFACT_WAR=$(artifacts.dir)/$WAR_NAME

echo "ARTIFACT_WAR name $ARTIFACT_WAR"

if [ -e  $ARTIFACT_WAR ]; then
     echo "copying the latest war to working dir $(work.dir)"
     sudo cp $ARTIFACT_WAR $(work.dir)/Azuredev.war
     exit 0
else
     exit 1
fi

if [ $? >1 ]; then
    echo "War file not copied to working directory, exiting process"
     exit 1
else
     echo "War file copied to working directory"
fi

echo "Build number to deploy as image on task 1 $BUILD_NUMBER"
