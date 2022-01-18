#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: bash ch-2.sh
#

set -f

declare -A pentagon

while true
do    ((p = p + n + n + n + 1))
      ((n ++))
      pentagon[$p]=1

      for seen in "${!pentagon[@]}"
      do  if ((seen + seen < p)) && [ -v pentagon[$((p - seen))] -a \
                                      -v pentagon[$((p - seen - seen))] ]
          then echo $seen" "$((p - seen))
               break 2
          fi
      done
done
