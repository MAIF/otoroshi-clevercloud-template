#!/usr/bin/env bash

echo "Run build from CC hooks"

LOCATION=`pwd`

function build_doc {
	echo "Running Doc build"	
	cd $LOCATION/otoroshi-sources/manual
	sbt paradox
	cp -rv ./target/paradox/site/main ../../public/docs
	cd $LOCATION
}

function build_ui {
	echo "Sourcing nvm"
	source /home/bas/.nvm/nvm.sh
	echo "using node version 8.6.0"
	nvm install v8.6.0
	nvm use v8.6.0
	echo "Installing Yarn"
	npm install -g yarn
	echo "Installing JS deps in javascript"
	cd ./javascript
	yarn install
	echo "Running JS build"
	yarn run build
	echo "Destroying dependencies cache"
	rm -rf ./node_modules
}


function cloning_sources {
	echo "Gloning sources from OSS repo"
	git clone https://github.com/MAIF/otoroshi.git otoroshi-sources --depth=1
}

function moving_sources {
	echo "Moving sources around"
	cp -r $LOCATION/otoroshi-sources/otoroshi/app $LOCATION/
	cp -r $LOCATION/otoroshi-sources/otoroshi/conf $LOCATION/
	cp -r $LOCATION/otoroshi-sources/otoroshi/javascript $LOCATION/
	cp -r $LOCATION/otoroshi-sources/otoroshi/project $LOCATION/
	cp -r $LOCATION/otoroshi-sources/otoroshi/public $LOCATION/
	cp -r $LOCATION/otoroshi-sources/otoroshi/test $LOCATION/
	cp -r $LOCATION/otoroshi-sources/otoroshi/build.sbt $LOCATION/
	cp $LOCATION/clevercloud/prod.conf $LOCATION/conf/
	cp $LOCATION/clevercloud/prod.xml $LOCATION/conf/
}

cloning_sources
moving_sources
build_doc
build_ui
