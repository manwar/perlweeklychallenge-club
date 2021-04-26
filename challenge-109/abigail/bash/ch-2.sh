#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

SIZE=7

#
# Just try all possibilities, but continue as soon as we know
# this cannot lead to a solution.
#
# We use 7 variables, a_i .. g_i indicating the indices of of
# the numbers we try for a .. g. We use nested loops to iterate
# over all the possibilties. We continue with the next iteration
# of a loop if:
#
#  - We pick an index which is already taken by an outer loop.
#  - We have a mismatch in the sums in the squares:
#       + We define a target = numbers [a_i] + numbers [b_i] 
#       + After picking c_i and d_i, we check whether 
#         numbers [b_i] + numbers [c_i] + numbers [d_i] equals target.
#       + After picking e_i and f_i, we check whether
#         numbers [d_i] + numbers [e_i] + numbers [f_i] equals target.
#       + After picking g_i, we check whether
#         numbers [f_i] + numbers [g_i] equals target.
#       + If we pass all tests, we have a solution.
#

while read -a numbers
do   for ((a_i = 0; a_i < SIZE; a_i ++))
     do  for ((b_i = 0; b_i < SIZE; b_i ++))
         do  if   ((a_i == b_i))
             then continue
             fi
             ((target = numbers[a_i] + numbers[b_i]))
             for ((c_i = 0; c_i < SIZE; c_i ++))
             do  if   ((a_i == c_i || b_i == c_i))
                 then continue
                 fi
                 for ((d_i = 0; d_i < SIZE; d_i ++))
                 do  if   ((a_i == d_i || b_i == d_i || c_i == d_i ||
                            target != numbers[b_i] + numbers[c_i] +
                                      numbers[d_i]))
                     then continue
                     fi
                     for ((e_i = 0; e_i < SIZE; e_i ++))
                     do  if   ((a_i == e_i || b_i == e_i ||
                                c_i == e_i || d_i == e_i))
                         then continue
                         fi
                         for ((f_i = 0; f_i < SIZE; f_i ++))
                         do  if   ((a_i == f_i || b_i == f_i ||
                                    c_i == f_i || d_i == f_i ||
                                    e_i == f_i ||
                                    target != numbers[d_i] + numbers[e_i] +
                                              numbers[f_i]))
                             then continue
                             fi
                             for ((g_i = 0; g_i < SIZE; g_i ++))
                             do  if   ((a_i == g_i || b_i == g_i ||
                                        c_i == g_i || d_i == g_i ||
                                        e_i == g_i || f_i == g_i ||
                                        target != numbers[f_i] + numbers[g_i]))
                                 then continue
                                 fi
                                 printf "%d %d %d %d %d %d %d\n" \
                                         ${numbers[$a_i]} ${numbers[$b_i]} \
                                         ${numbers[$c_i]} ${numbers[$d_i]} \
                                         ${numbers[$e_i]} ${numbers[$f_i]} \
                                         ${numbers[$g_i]}
                             done
                         done
                     done
                 done
             done
         done
     done
done
