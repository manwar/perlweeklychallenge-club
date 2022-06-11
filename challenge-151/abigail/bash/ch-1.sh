#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

declare -A tree

while read -a tokens
do    tree=()
      D=0
      i=0
      for token in ${tokens[@]}
      do  if [ $token == "|" ]
          then D=$((D + 1))
               i=0
          else key=$D,$i
               if [ $token != "*" ]
               then tree[$key]=1
               fi
               i=$((i + 1))
          fi
      done

      for ((d = 0; d <= D; d ++))
      do  for ((i = 0; i < 2 ** d; i ++))
          do  if [[   -v tree[$d,$i]                      ]] && \
                 [[ ! -v tree[$((d + 1)),$((2 * $i))]     ]] && \
                 [[ ! -v tree[$((d + 1)),$((2 * $i + 1))] ]]
              then echo $((d + 1))
                   break 2
              fi
          done
      done
done
