# Print all the niven numbers from 0 to 50 inclusive, each on their own line.
# A niven number is a non-negative number that is divisible by the sum of its digits.

use strict;
use warnings;
use utf8;
use v5.10;

sub is_niven {
    my $n   = shift;
    my $sum = 0;
    $sum += $_ for split '', $n;
    return !( $n % $sum );
}

is_niven($_) && say for 1 .. 50;
