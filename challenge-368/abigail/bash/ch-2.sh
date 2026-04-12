#!/opt/homebrew/bin/bash

while read number mode
do   ((diff_factors = 0))
     ((     factors = 0))

     #
     # Try dividing by all odd numbers -- but use 2 if the number is 1.
     # Count different and total factors.
     #
     # Note that this way, we will never divide by a composite number --
     # if we encounter a composite number, we have already tried its factors.
     #
     for ((d = 1; d * d <= number; d += 2))
     do    ((n = d == 1 ? 2 : d))
           ((rem = number % n))
           if [[ $rem -eq 0 ]]
           then ((diff_factors ++))
                while [[ $rem -eq 0 ]]
                do    ((factors ++))
                      ((number /= n))
                      ((rem = number % n))
                done
           fi
     done

     #
     # At this point, number is either 1 or a large prime, not encountered
     # before. In the later case, add one of the number of factors and unique
     # factors.
     #
     if   [[ $number -ne 1 ]]
     then ((diff_factors ++))
          ((factors ++))
     fi

     #
     # Print the appropriate tally
     #
     if   [[ $mode -eq 1 ]]
     then echo $factors
     else echo $diff_factors
     fi
done
