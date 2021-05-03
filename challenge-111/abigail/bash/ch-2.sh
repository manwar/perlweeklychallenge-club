#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#


set -f
shopt -s extglob

pat1="*(a)*(b)*(c)*(d)*(e)*(f)*(g)*(h)*(i)*(j)*(k)*(l)*(m)"
pat2="*(n)*(o)*(p)*(q)*(r)*(s)*(t)*(u)*(v)*(w)*(x)*(y)*(z)"

longest=""

while read line
do    lower=${line,,}                 # Lower case input
      left=${lower/#$pat1$pat2/}      # Remove pattern
                                      # Test whether nothing left,
                                      # and string larger longest found
      if   [ "X$left" == "X" -a ${#line} -gt ${#longest} ]
      then longest=$line
      fi
done

echo $longest
