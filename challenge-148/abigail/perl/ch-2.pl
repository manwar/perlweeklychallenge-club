#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: perl ch-2.pl
#

#
# Cardona Triplets are also subject of Project Euler, task 251
#

#
# While the challenge defines what a Cardano Triplet is, it doesn't
# define how to order them. Given triplets t1 = (a1, b1, c1) and
# t2 = (a2, b2, b3), how do we determine t1 <=> t2?
#
# Order them on (a1 + b1 + c1) <=> (a2 + b2 + c2)?
# Order them on  a1 <=> a2 || b1 <=> b2?
# Order them on  min (a1, b1, c1) <=> min (a2, b2, c2) (with ties
#     broken on the second smallest number)? (Since for each possible
#     a, there is a solution with b = 1, this may be boring).
# Some other order?
#
# We will pick the first one.
#

#
# With some manipulation, it can be show that
#
#  cbrt (a + b * sqrt (c)) + cbrt (a - b * sqrt (c)) == 1  <=>
#
#  8 * a^3 + 15 * a^2 + 6 * a - 27 * b^2 * c == 1
#
#  Take this modulo 3, and we get:
#
#  8 * a^3 + 15 * a^2 + 6 * a - 27 * b^2 * c === 1 mod 3,
#
# which, since 15, 6 and 27 are multiples of 3, and 8 === 2 mod 3,
# reduces to:
#
#  2 * a^3 === 1 mod 3  <=>  (multiply boths sides with 2):
#
#  4 * a^3 === 2 mod 3   =>
#
#  a === 2 mod 3
#
# So, we can generate the a's with 3 * k + 2, k >= 0.
#
# 27 * b^2 * c == 8 * a^3 + 15 * a^2 + 6 * a - 1
#              == 8 * (3 * k + 2)^3 + 15 * (3 * k + 2) ^ 2 + 6 * (3 * k + 2) - 1
#              == 216 * k^3 + 432 * k^2 + 288 * k +  64
#                           + 135 * k^2 + 180 * k +  60
#                                       +  18 * k +  12 - 1 
#              == 216 * k^3 + 567 * k^2 + 486 * k + 135
#              == 27 * (k + 1) ^ 2 * (8 * k + 5)             <=>
#
#      b^2 * c == (k + 1) ^ 2 * (8 * k + 5)
#
# Now, b = (k + 1), c = (8 * k + 5) gives a triple for a = 3 * k + 2,
# but that is not the only solution for a given a.
#
# *Each* divisor d1 of k + 1 (including 1 and k + 1) is a valid solution
# for b. Furthermore, for each divisor of d2 of 8 * k + 5, if d2 is a square
# sqrt (d2) is a solution for b. Finally, each product d1 * sqrt (d2)
# is a solution for b.
#
# If we know k and b, we can calculate c as:
#
#    c = (k + 1)^2 * (8 * k + 5) / b^2
#

#
# To know when we can stop generating triples, we keep the 5 best
# triples so far, updating them each time we find a better triple.
# Once 3 * k + 2 (= a) exceeds the sum of the fifth triple, we know
# we cannot find better.
#

#
# Note that while we generate and print the first 5 triplets, we 
# will NOT print them in order. This is not a requirement.
#

use Math::Prime::Util qw [divisors];
use List::Util        qw [sum max];

my $COUNT = 5;
my $A     = 0;
my $B     = 1;
my $C     = 2;
my $SUM   = 3;
my @out;
foreach my $i (0 .. $COUNT - 1) {
    $out [$i]        = [(999999) x 3];
    $out [$i] [$SUM] = sum @{$out [$i]};
}

my $max_index = 0;

for (my $k = 0; 3 * $k + 2 <= $out [$max_index] [$SUM]; $k ++) {
    my $a  = 3 * $k + 2;
    my $f1 =     $k + 1;
    my $f2 = 8 * $k + 5; 

    #
    # Divisors of (k + 1)
    #
    my @d1 = divisors ($f1);

    #
    # Squares of divisors of (8k + 5), which are integers.
    #
    my @d2 = grep {$_ == int ($_)} map {sqrt $_} divisors ($f2);

    #
    # Calculate all the solutions for b and c (for this k)
    #
    foreach my $d1 (@d1) {
      D2:
        foreach my $d2 (@d2) {
            my $b = $d1 * $d2;
            my $c = $f1 * $f1 * $f2 / ($b * $b);
            if ($a + $b + $c < $out [$max_index] [$SUM]) {
                #
                # Avoid duplicate entries
                #
                foreach my $info (@out) {
                    next D2 if $$info [$A] == $a && $$info [$B] == $b;
                }

                #
                # Put triple in the output structure
                #
                $out [$max_index] = [$a, $b, $c, $a + $b + $c];

                #
                # Find the index of the new highest value
                #
                $max_index = 0;
                my $max_sum = $out [$max_index] [$SUM];
                for (my $i = 1; $i < $COUNT; $i ++) {
                    if ($out [$i] [$SUM] > $max_sum) {
                        $max_index = $i;
                        $max_sum   = $out [$i] [$SUM];
                    }
                }
            }
        }
    }
}


say "@$_[$A, $B, $C]" for @out;

__END__
