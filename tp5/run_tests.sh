#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/CPLEX/opl/bin/x86-64_sles10_4.1

i=0
conf_opl
for f in instancesbis/* 
do
  ~/CPLEX/opl/bin/x86-64_sles10_4.1/oplrun ppce.mod $f > res4_bis/res$i
  let i++
  echo $i
done



