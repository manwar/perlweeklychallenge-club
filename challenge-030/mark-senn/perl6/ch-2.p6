#
# Perl Weekly Challenge - 030
# Task #2
#
# Mark Senn, http://engineering.purdue.edu/~mark
# October 19, 2019
#
# From
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-030#task-2
#     Write a script to print all possible series of 3 positive numbers,
#     where in each series at least one of the number is even and sum of
#     the three numbers is always 12. For example, 3,4,5.
#
# The sum of any three odd positive numbers will always be odd.  So,
# any three positive numbers that add to 12 must have at least one
# even number.  The task can be restated as
#     Write a script to print all possible series of 3 positive numbers
#     where the sum of the numbers is 12.  For example, 3,4,5.
#
# THIS WOLFRAM LANGUAGE (FORMERLY KNOWN AS MATHEMATICA) PROGRAM CAN BE USED
# TO SOLVE THIS PROGRAM:
#     s   =   Solve[i+j+k == 12 && i>0 && j>0 && k>0,  {i,j,k},  Integers];
#
#     For [t=1, t<=Length[s], t++,
#         Print[i/.s[[t,1]], ",", j/.s[[t,2]], ",", k/.s[[t,3]]];
#     ];
#
# Perl 6 is in the process of being renamed Raku.
# Run using Raku v6.d;
use v6.d;

sub MAIN()
{
    for (1..10) -> $i  {
        for (1..10) -> $j  {
            for (1..10) -> $k  {
                ($i + $j + $k == 12)  and  say "$i,$j,$k";
            }
        }
    }

    # Optimize so we don't need to examine as many numbers.
    for (1..10) -> $i  {
        for (1..12-$i-1) -> $j  {
            for (12-$i-$j..10) -> $k  {
                ($i + $j + $k == 12)  and  say "$i,$j,$k";
            }
        }
    }
}

# For each example, the program printed:
#     1,1,10
#     1,2,9
#     1,3,8
#     1,4,7
#     1,5,6
#     1,6,5
#     1,7,4
#     1,8,3
#     1,9,2
#     1,10,1
#     2,1,9
#     2,2,8
#     2,3,7
#     2,4,6
#     2,5,5
#     2,6,4
#     2,7,3
#     2,8,2
#     2,9,1
#     3,1,8
#     3,2,7
#     3,3,6
#     3,4,5
#     3,5,4
#     3,6,3
#     3,7,2
#     3,8,1
#     4,1,7
#     4,2,6
#     4,3,5
#     4,4,4
#     4,5,3
#     4,6,2
#     4,7,1
#     5,1,6
#     5,2,5
#     5,3,4
#     5,4,3
#     5,5,2
#     5,6,1
#     6,1,5
#     6,2,4
#     6,3,3
#     6,4,2
#     6,5,1
#     7,1,4
#     7,2,3
#     7,3,2
#     7,4,1
#     8,1,3
#     8,2,2
#     8,3,1
#     9,1,2
#     9,2,1
#     10,1,1
