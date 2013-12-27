#!/bin/sh

if [ -z $1 ]; then
    echo "Usage: $0 appname"
    exit 1
fi

cd apps/template/src
sed -i "s/template/$1/g" *
mv template.app.src $1.app.src
mv template_app.erl $1_app.erl
mv template_sup.erl $1_sup.erl
mv template.erl $1.erl
mv template.hrl $1.hrl

cd ../..
mv template $1

cd ..
sed -i "s/template/$1/g" Makefile
sed -i "s/template/$1/g" Emakefile
sed -i "s/template/$1/g" rebar.config
sed -i "s/template/$1/g" template.cfg
mv template.cfg $1.cfg

rm README.md
rm $0
rm -rf .git
