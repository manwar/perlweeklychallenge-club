# Write a script that computes the first five perfect numbers.
# A perfect number is an integer that is the $sum of its positive proper divisors (all divisors except itself).
# Please check Wiki for more information. This challenge was proposed by Laurent Rosenfeld.

use strict;
use warnings;
use v5.10;

# we start by defining a sub that checks if a number is perfect (i.e is equal lo the sum of all its divisors):

sub is_perfect {
    my $x   = shift;
    my $sum = 0;
    for my $d ( 1 .. $x - 1 ) {
        $sum += $d unless $x % $d;
    }
    return $sum == $x;
}

# as using this formula to test all integers (or even restricted to odd numbers) will take forever, we
# use other property of perfect numbers. They have the binary form of x ones (1) followed by x-1 zeros (0)
# note that 2 ^ x - 1 will give you a binary number of x ones, and if you multiply this number for
# 2 ^ (x-1) yow will be adding x - 1 zeros to the right.

sub get_candidate {
    my $p = shift;
    return undef unless ( $p && $p > 0 && $p < 33 );
    my $pwr2 = 1;
    $pwr2 *= 2 while --$p;    # $pwr2 will be 2 ^ ($p-1)
    return ( $pwr2 * 2 - 1 ) * $pwr2;

    # this will be '1' x $p . '0' x ($p-1) in binary
}

# now we calculate all perfect number cases starting on get_candidate(2) until we get 5

my $q    = 5;                 # we need five perfect numbers
my $ones = 2;                 #start with 2 ones and a 0 (110, i.e, 6)
while ($q) {
    my $candidate = get_candidate($ones);
    $q-- && say $candidate if is_perfect($candidate);
    $ones++;
}

# note that 5 is the maximum amount of perfect numbers that you can get with 32 bit arithmetics, as the 6th
# one is 0b111111111111111110000000000000000 (17 ones and 16 zeros)
#
# calculating the first 5 takes 1.8 secs on my machine, if you want to get up to the sixth you can change $q
# assignement to 6 in line 34 (provided that your perl has 64 bit arithmetics) , but the time to complete the
# calculations increases to almost 8 min. This is because the is_perfect function has to as many divisions as
# the number is checking minus one, so for the 6 perfect number that will be 858,986,056 divisions only for
# the last check
