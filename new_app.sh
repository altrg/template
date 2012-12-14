#!/bin/sh

if [ -z $1 ]; then
    echo "Usage: $0 appname"
    exit 1
fi

cd apps/template/src
sed -i "s/template/$1/g" template.app.src
sed -i "s/template/$1/g" template_app.erl
sed -i "s/template/$1/g" template_sup.erl
sed -i "s/template/$1/g" template.hrl
sed -i "s/template/$1/g" template.erl
mv template.app.src $1.app.src
mv template_app.erl $1_app.erl
mv template_sup.erl $1_sup.erl
mv template.hrl $1.hrl
mv template.erl $1.erl

cd ../../../priv
sed -i "s/template/$1/g" node.config
mv template.cfg $1.cfg

cd ..
sed -i "s/template/$1/g" Makefile
sed -i "s/template/$1/g" rebar.config

mv apps/template apps/$1

rm $0
