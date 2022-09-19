package My::Prime::Util;

use strict;
use warnings;
use feature qw'signatures';
no warnings qw'experimental::signatures';

use Exporter qw(import);

our @EXPORT_OK = qw(is_prime);

# Naive primality check. Used before exctracting here in for example Challenge
# 150 and Challenge 158
# is_prime: Int -> Boolean
sub is_prime($x) {
    return 0 if $x <= 1;
    return 1 if $x <= 3;
    for ( my $i = 2 ; $i <= sqrt($x) ; $i++ ) {
        return 0 if $x % $i == 0;
    }
    return 1;
}

1;
