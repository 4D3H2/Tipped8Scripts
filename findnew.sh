#!/bin/sh
. $HOME/.profile

cd $COINBIN
for a in $(ls *d)
do
  name=$(echo $a|sed 's/.$//')
  if [ -f $COINSCRIPTS/$name.daemon ]
  then
	continue
  fi
  cp -v $COINSCRIPTS/.template.daemon $COINSCRIPTS/$name.daemon
  sed -i "s/template/$name/g" $COINSCRIPTS/$name.daemon
  chmod +x $COINSCRIPTS/$name.daemon
  mkdir $HOME/.$name
  mkdir $COINDATA/$name
  cp -v $COINDATA/.template.conf $HOME/.$name/$name.conf
  sed -i "s/template/$name/g" $HOME/.$name/$name.conf
  sed -i "s/password=/password=$(pwgen -cnsB -1 45 1)/" $HOME/.$name/$name.conf
  cp -v $HOME/.$name/$name.conf $COINDATA/$name/$name.conf
done
