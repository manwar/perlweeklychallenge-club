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
#     broken on the second smallest number)?
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
# So, how many k do we have to try? We start generating triples.
# As soon as we have 5 of them, we find the sum of the 5th triple.
# We then continue until 3 * k + 2 exceeds this sum.
#

use Math::Prime::Util qw [divisors];
use List::Util        qw [sum max];

my @out;

my $COUNT = 5;

my $max;

for (my $k = 0; !$max || 3 * $k + 2 <= $max; $k ++) {
    my $A  = 3 * $k + 2;
    my $f1 =     $k + 1;
    my $f2 = 8 * $k + 5; 

    my %seen;
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
        foreach my $d2 (@d2) {
            $seen {$d1 * $d2} = ($f1) ** 2 * $f2 / ($d1 * $d1 * $d2 * $d2);
        }
    }

    #
    # Add solutions to @out
    #
    push @out => map {[$A, $_, $seen {$_}]} keys %seen;

    #
    # Find the stopping requirement.
    #
    if (!$max && @out >= $COUNT) {
        @out = sort {sum (@$a) <=> sum (@$b)} @out;
        $max = sum @{$out [$COUNT - 1]};
    }
}


@out = sort {sum (@$a) <=> sum (@$b)} @out;

say "@$_" for @out [0 .. $COUNT - 1];

__END__
