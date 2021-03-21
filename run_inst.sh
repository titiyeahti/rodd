#!/bin/bash
# run_inst.sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/CPLEX/opl/bin/x86-64_sles10_4.1/

if [[ $1 ]] 
then 
  target=$1
else
  target=1
fi


tp=tp$target

if [[ $2 ]]
then 
  mod=$tp\_$2
else
  mod=$tp
fi

echo $tp $mod

i=0
for f in instances/$tp/*
do 
  ~/CPLEX/opl/bin/x86-64_sles10_4.1/oplrun $tp/$mod.mod $f | 
    \grep "##" | cut -c3- >> plot_data/$mod.dat
  let i++
  echo $i
done
