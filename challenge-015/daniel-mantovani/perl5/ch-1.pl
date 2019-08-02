# Write a script to generate first 10 strong and weak prime numbers.

#   For example, the nth prime number is represented by p(n).

#   p(1) = 2
#   p(2) = 3
#   p(3) = 5
#   p(4) = 7
#   p(5) = 11

#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

use strict;
use warnings;
use v5.10;

# we sart by using the same prime test used to solve challenge 12 - 1
# (the regexp prime tester)
#

sub is_prime {
    return ( 7 x shift ) !~ /^(77+)\1+$/;
}

# we will allow changing the size of the lists, and use 10 as the default
my $list_length = shift // 10;    #

# we define array for all primes, populating with the first two,
# so for n=2, p(n-1) would be 2, p(n) is 3, and p(n+1) is yet
# to be calculated

my @primes = ( 2, 3 );

# we also define arrays for strong and weak primes
my ( @strong, @weak );

# we will loop until we get at least required amount for both strong and weak primes
while ( @strong < $list_length || @weak < 10 ) {
    my $p_n   = $primes[-1];    # this is p(n)
    my $p_nmm = $primes[-2];    # this is p(n-1)
    my $p_npp = $p_n + 1;       # and we will calculate p(n+1)

    # get next prime
    $p_npp++ while !is_prime($p_npp);
    push @primes, $p_npp;
    my $check = ( $p_nmm + $p_npp ) / 2;
    push @strong, $p_n if $p_n > $check;
    push @weak,   $p_n if $p_n < $check;
}

# now we just print results
say "First $list_length strong primes: " . join ', ', @strong;
say "First $list_length weak primes: " . join ', ',   @weak;
