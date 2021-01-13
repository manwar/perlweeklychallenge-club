#! /opt/local/bin/perl
#
#       power_to_the_wholes.pl
#
#         TASK #2 › Power of Two Integers
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N.
#
#         Write a script to find if it can be expressed as a ^ b
#         where a > 0 and b > 1. Print 1 if you succeed otherwise 0.
#
#
#         Example 1:
#             Input: 8
#             Output: 1 as 8 = 2 ^ 3
#
#         Example 2:
#             Input: 15
#             Output: 0
#
#         Example 3:
#             Input: 125
#             Output: 1 as 125 = 5 ^ 3
#
#         method:
#             two solutions are provided.  They both function the same way, only
#             one is a more verbose version that discusses the results and the other a minimal version
#             without frills that returns 1/0.

#             Both check every number up to the square root of
#             the target for divisibility. If a number is found to be a factor,
#             the target value is divided and the remainder checked; this
#             process continues until the last division yields a quotient of 1
#             or a remainder is found.

#             In the compact version the requested response is provided, so on
#             the first occurance of completely dividing the target down a 1 is
#             output and the program exits. In the verbose version the sucessful
#             value and power is noted and evaluation continues to find all
#             possible combinations of n ^ m that produce the target.
#
#             As almost all numbers will not divide out and only a few will
#             continue up into multiple powers, the number of values checked
#             approaches just the square root, with checking multiple powers
#             making no meaningful difference as the input values get larger.

#             thus algorithmic complexity is O(√n)


#             By setting the $VERBOSE flag to 2, an complete blow-by-blow of the
#             calculation is displayed.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $VERBOSE = 1;

my $input = shift @ARGV || 16777216;          ## 2^16, etc

$VERBOSE and do {
    say $_ for root_power_verbose($input);
    say '';
};

# minimal
for my $try ( 2..sqrt $input ) {
    my $copy = $input;
    while ($copy % $try == 0) {
        $copy /= $try;
        $copy == 1 and say 1 and exit;
    }
}

say 0;


## verbose
## takes longer because it will not short-circuit, returns list of all solutions
sub root_power_verbose {
    my ($input) = @_;
    my $max = sqrt $input;
    my @out;

    for my $try ( 2..$max ) {
        say "trying $try" if $VERBOSE == 2;
        my $count = 0;
        my $copy = $input;
        while ($copy % $try == 0) {
            $count++;
            say "\tcount is $count"  if $VERBOSE == 2;
            $copy /= $try;
            if ($copy == 1) {
                say "\t\t\tsuccess!"  if $VERBOSE == 2;
                push @out, "$try ^ $count";
            }
        }
    }
    return @out ? @out
                : "no powers found";
}
