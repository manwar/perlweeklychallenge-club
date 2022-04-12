package main;
use strict;
use warnings;
use Math::Prime::Util qw/factor/;

sub get_moebius_nr {
    my $what = shift;

    my @factors = factor($what);

    my %fact_hash;

    for my $fact (@factors) {
        $fact_hash{$fact} += 1;
        if ( $fact_hash{$fact} == 2 ) {
            return 0;
        }
    }

    return 1 if scalar @factors % 2 == 0;
    return -1;

}

use Test::More;

is( get_moebius_nr(5),  -1 );
is( get_moebius_nr(10), 1 );
is( get_moebius_nr(20), 0 );

done_testing;
1;
