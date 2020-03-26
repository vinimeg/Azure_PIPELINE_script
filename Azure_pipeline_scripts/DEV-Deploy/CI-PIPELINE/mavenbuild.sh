#!/bin/bash

echo "target directry $(build.dir)"


cd $(build.dir)

sudo mvn clean install -Dmaven.test.skip=true

if [ -d $(war.dir) ]; then
    echo "Builded the war successfully"
else
    echo "Build failed"
fi

