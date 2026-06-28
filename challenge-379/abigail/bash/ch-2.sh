#!/opt/homebrew/bin/bash

while read base limit
do    for ((n = 0; n <= limit; n ++))
      do  ((size = 0))
          for  ((n_c = n; n_c; n_c /= base))
          do   ((size ++))
          done
          ((sum = 0))
          for  ((n_c = n; n_c; n_c /= base))
          do   ((sum += (n_c % base) ** size))
          done
          if   ((sum == n))
          then echo -n "$n "
          fi
      done
      echo ""
done
