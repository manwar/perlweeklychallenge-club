package main;
use strict;
use warnings;
use Math::Prime::Util qw/next_prime/;

sub gen_primorial_nums {
    my $count = shift;

    my @nums     = (1);
    my $at_prime = 1;

    while ( scalar @nums < $count ) {
        $at_prime = next_prime($at_prime);

        push @nums, $nums[-1] * $at_prime;
    }

    return \@nums;
}

use Test::More;

is_deeply( gen_primorial_nums(3), [ 1, 2, 6 ], 'Test first 3 numbers' );
is_deeply(
    gen_primorial_nums(10),
    [ 1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870 ],
    'Test first 10 numbers'
);

done_testing;

1;
