#!/bin/bash

BUILD_NUMBER=$(Build.BuildNumber)

echo "BUILD_NUMBER is $BUILD_NUMBER"

WAR_NAME="Azuredev.war"

echo "WAR_NAME name $WAR_NAME"

DEV_WAR=$(dev.dir)/$WAR_NAME

echo "DEV_WAR name $DEV_WAR"

if [ -e  $DEV_WAR ]; then
     echo "copying the latest war to working dir $(work.dir)"
     sudo cp $DEV_WAR $(work.dir)/Azuredev.war
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

