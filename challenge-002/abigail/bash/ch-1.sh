#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
#

#
# Run as: bash ch-1.sh < input-file
#

shopt -s extglob

while read number
do echo "${number##+(0)}"
done
