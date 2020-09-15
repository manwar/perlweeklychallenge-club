#!/opt/perl/bin/perl

#
# Exercise:
#     You are given a positive integer $N.
#     Write a script to find out all possible combination of Fibonacci
#     Numbers required to get $N on addition.
#
#     You are NOT allowed to repeat a number. Print 0 if none found.
#

#
# Note:
#    The "Print 0 if none found." is irrelevant. There is always at
#    least one way to write any positive integer as a sum of distinct
#    Fibonacci Numbers. (Zeckendorf's theorem states: "very positive
#    integer can be represented uniquely as the sum of one or more
#    distinct Fibonacci numbers in such a way that the sum does not
#    include any two consecutive Fibonacci numbers")
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

chomp (my $N = <>);

#
# Create a list of Fibonacci Numbers up to $N. We will start with (1, 2),
# skipping the first two numbers 0 and 1. 0 doesn't add anything, and
# we cannot duplicate numbers, so we just need one 1.
#
my @FIB = (1, 2);
while ($FIB [-1] + $FIB [-2] <= $N) {
    push @FIB => $FIB [-1] + $FIB [-2];
}

sub solutions;

#
# Create all solutions for number $target, with all Fibonnaci numbers
# having index $index or above.
#
sub solutions ($target, $index = 0) {
    map {
        my $fib = $FIB [$_];
        $target  < $fib ? ()
      : $target == $fib ? [$target]
      : map {[$fib, @$_]} solutions ($target - $fib, $_ + 1)
    } $index .. @FIB - 1;
}

my @all = solutions $N;

local $" = " + ";
say "@$_ = $N" for @all;

__END__
