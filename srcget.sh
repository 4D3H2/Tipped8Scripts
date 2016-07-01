#!/bin/sh

for a in $(cat $MASTERLIST);do git clone $a;done
