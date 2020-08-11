#
# Perl  Weekly  Challenge  - 022
# Task #1
#
# See
#      engineering.purdue.edu/~mark/pwc -022 -1. pdf
# for  more  information.

# Run  using  Perl v6.d.
use v6.d;

my$d     =   6;    # sexy  primes  differ  by 6
my$n     = 10;     # print  the  first$n sexy  prime  pairs
my$p     =   0;     # how  many  sexy  prime  pairs  have  been  printed
my$size =   2;     # size of the  circular  buffer

# Make a$size  element  circular  buffer.
# Make  each  element  the  illegal  value  of 2 -$d - 1 (=  -5).
# The  circular  buffer  will  get  seeded  with  the  correct  values  later.
# The  first  sexy  prime  pair  will be found  at (5 ,11).
my @cb[$size] = (2-$d -1) xx *;

my$i = 0;                                  # Current  index  into cb
for  ((2.. Inf).grep ({.is -prime })) {    # For  each  prime  number ...
    if ($_ -$d == @cb.any)   {             #    is it part of a sexy  prime  pair?
        "({$_ -$d},$_)". say;              #      print  the  sexy  prime  pair
        (++$p ==$n)   and   last;          #      have we  printed$n sexy  prime  pairs?
    }
    @cb[$i++ %$size] =$_;                  # put  the  new  prime  in the  circlar  buffer
    # say "cb = {@cb}";                    # (for  testing)
}
