package main;
use strict;
use warnings;
use List::Util qw/uniq/;
use Algorithm::Combinatorics qw /combinations/;

sub get_bitwise_sum {
    my @what = @_;

    # it says we should consider only unique pairs
    @what = uniq @what;

    my $sum  = 0;
    my $iter = combinations( \@what, 2 );

    while ( my $c = $iter->next ) {
        $sum += $c->[0] & $c->[1];
    }

    return $sum;
}

use Test::More;

is( get_bitwise_sum( 1, 2, 3 ),    3 );
is( get_bitwise_sum( 1, 1, 2, 3 ), 3 );
is( get_bitwise_sum( 2, 3, 4 ),    2 );

done_testing;
1;
