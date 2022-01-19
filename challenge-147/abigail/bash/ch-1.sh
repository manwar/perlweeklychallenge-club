#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: bash ch-1.sh
#

set -f

function is_prime () {
    local n=$1
    local i
    is_prime=1
    if ((n > 2 && n % 2 == 0)) 
    then is_prime=0
    else for ((i = 3; i * i <= n && is_prime == 1; i += 2))
         do  if ((n % i == 0))
             then is_prime=0
             fi
         done
    fi
}

todo=(2 3 5 7)
count=20

for p in "${todo[@]}"
do  printf "$p "
    ((count --))
done


while ((count > 0))
do    next=()
      for ((d = 1; d <= 9 && count > 0; d ++))
      do  for p in "${todo[@]}"
          do  candidate=$d$p
              is_prime $candidate
              if (($is_prime == 1))
              then printf $candidate" "
                   ((count --))
                   next+=($candidate)
                   if ((count <= 0))
                   then break
                   fi
              fi
          done
     done
     todo=("${next[@]}")
done

echo
