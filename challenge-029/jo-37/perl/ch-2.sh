#!/bin/sh

MOD=CH_2

if [ ! -f $MOD/blib/lib/$MOD.pm -o ! -f $MOD/blib/arch/auto/$MOD/$MOD.so ]
then
	cat <<EOD

Instructions
============

The module $MOD needs to be built first.  Follow these steps:
\$ cd $MOD
\$ perl Makefile.PL
\$ make

Afterwards call "$0 x" (from this directory) to calculate the error
function erf(x) from the C math library.

EOD
	exit 1
fi

perl -I$MOD/blib/lib -I$MOD/blib/arch/auto/$MOD -M$MOD=:all \
	-E "say erf shift" -- $1
