# The Weekly Challenge 252
# Task 1 Special Numbers
use v5.30.0;
use warnings;
use Math::Prime::Util qw/divisors/;

sub sn {
    my @ints = @_;
    my @divisors = divisors(scalar @ints);
    my $sum = 0;
    for (@divisors) {
        my $j = $_-1;
        $sum += $ints[$j]*$ints[$j]
    }
    return $sum;
}

use Test::More tests=>2;
ok sn(1,2,3,4)==21;
ok sn(2, 7, 1, 19, 18, 3)==63;
