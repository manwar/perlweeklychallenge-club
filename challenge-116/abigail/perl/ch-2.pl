#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#
use List::Util qw [sum];

#
# Print 1 if the squares of the digits sum to a perfect square, 0 otherwise.
#
while (<>) {
    # Calculate the sum of the squares of the digits.
    my  $sum_of_squares = sum map {$_ * $_} /[1-9]/g;  # Ignore 0s
    # Is it a perfect square? (Take care of rounding errors).
    say $sum_of_squares == int (.5 + sqrt $sum_of_squares) ** 2 ? 1 : 0
}
