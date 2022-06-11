package main;

use strict;
use warnings;

use List::Util qw/sum product/;

sub calc_am {
    my @what = @_;

    return sprintf( '%.1f', sum(@what) / scalar @what );
}

sub calc_gm {
    my @what = @_;

    return sprintf( '%.1f', abs( product(@what) )**( 1 / scalar @what ) );
}

sub calc_hm {
    my @what = @_;

    my $sum = 0;

    for my $item (@what) {
        $sum += 1 / $item;
    }

    return sprintf( '%.1f', scalar @what / $sum );
}

sub calc_means {
    my (@what) = @_;

    return
          "AM = "
        . calc_am(@what) . ", GM="
        . calc_gm(@what) . ", HM="
        . calc_hm(@what);
}

use Test::More;

is( calc_means( ( 1, 3, 5, 6, 9 ) ),
    'AM = 4.8, GM=3.8, HM=2.8',
    'Test 1 3 5 6 9'
);
is( calc_means( ( 2, 4, 6, 8, 10 ) ),
    'AM = 6.0, GM=5.2, HM=4.4',
    'Test 2 4 6 8 10'
);
is( calc_means( ( 1, 2, 3, 4, 5 ) ),
    'AM = 3.0, GM=2.6, HM=2.2',
    'Test 1 2 3 4 5'
);

done_testing;
1;
