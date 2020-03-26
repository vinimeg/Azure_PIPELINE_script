#!/bin/bash

sudo rm -rf $(misc.dir)/*

BUILD=$(Build.BuildNumber)

echo "BUILD number is $BUILD"

ARTIFACT_WAR="azure-$BUILD.war"

echo "ARTIFACT WAR name is $ARTIFACT_WAR"

# storing the build name into a file for other env deployment
echo "$ARTIFACT_WAR" | sudo tee -a $(misc.dir)/latest_dev_build

cd $(build.dir)

#copy the war to artifact directory
if [ -d $(war.dir) ]; then
    sudo cp ./target/azure.war $(artifacts.dir)/$ARTIFACT_WAR
else
    echo "No target directory found"
    exit 1
fi



LATEST_BUILD=$ARTIFACT_WAR

echo "Printing latest_build $LATEST_BUILD"


