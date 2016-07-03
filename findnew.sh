#!/bin/sh
. $HOME/.profile

cd $COINBIN
for a in $(ls *d)
do
  name=$(echo $a|sed 's/.$//')
  if [ -f $COINSCRIPTS/$name.tx ]
  then
	continue
  fi
  cp -v $COINSCRIPTS/.template.daemon $COINSCRIPTS/$name.daemon
  sed -i "s/template/$name/g" $COINSCRIPTS/$name.daemon
  chmod +x $COINSCRIPTS/$name.daemon
  if [ -f $COINBIN/$name-cli ]
  then
	cp -v $COINSCRIPTS/.template.cli $COINSCRIPTS/$name.cli
  else
	cp -v $COINSCRIPTS/.template.daemon $COINSCRIPTS/$name.cli
  fi
  if [ -f $COINBIN/$name-tx ]
  then
	cp -v $COINSCRIPTS/.template.tx $COINSCRIPTS/$name.tx
  else
	cp -v $COINSCRIPTS/.template.daemon $COINSCRIPTS/$name.tx
  fi
  sed -i "s/template/$name/g" $COINSCRIPTS/$name.cli
  sed -i "s/template/$name/g" $COINSCRIPTS/$name.tx
  chmod +x $COINSCRIPTS/$name.cli
  chmod +x $COINSCRIPTS/$name.tx
  if [ -d $HOME/.$name -a $COINDATA/$name ]
  then
	continue
  fi
  mkdir $HOME/.$name
  mkdir $COINDATA/$name
  cp -v $COINDATA/.template.conf $HOME/.$name/$name.conf
  sed -i "s/template/$name/g" $HOME/.$name/$name.conf
  sed -i "s/password=/password=$(pwgen -cnsB -1 45 1)/" $HOME/.$name/$name.conf
  cp -v $HOME/.$name/$name.conf $COINDATA/$name/$name.conf
done
