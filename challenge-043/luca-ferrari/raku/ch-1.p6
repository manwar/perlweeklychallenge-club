#!env perl6

# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-043/>
# Task 1: Olympic Rings
# We have allocated some numbers to these rings as below:
# Blue: 8
# Yellow: 7
# Green: 5
# Red: 9

# The Black ring is empty currently.
# You are given the numbers 1, 2, 3, 4 and 6.
# Write a script to place these numbers in the rings so that the sum of numbers in each ring is exactly 11.

my %available-numbers = 1 => True, 2 => True, 3 => True, 4 => True, 6 => True;
my %rings = Blue => [8], Yellow => [7], Green => [5], Red => [9];
for %rings.kv -> $color, @numbers {
    my $need = 11 - @numbers[ 0 ];

    if ?%available-numbers{ $need } {
       # append the new number to the container, and thus to the hash
       @numbers.push: $need;
       %available-numbers{ $need } = False;
      "\nRing %s contains (%s)".printf: $color, @numbers.join( ' & ' );
    }
    else {
        say "Cannot find the required number $need as available for ring $color!";
    }
}
