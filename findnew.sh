#!/bin/sh

cd $COINBIN
for a in $(ls *d)
do
  name = $(echo $a|sed 's/.$//')
  cp -v $COINSCRIPTS/.template.daemon $COINSCRIPTS/$name.daemon
  sed -i "s/template/$name/" $COINSCRIPTS/$name.daemon
done
