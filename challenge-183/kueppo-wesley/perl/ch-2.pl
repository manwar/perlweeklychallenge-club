#!/usr/bin/env perl

use strict;
use warnings;

use DateTime;
use Test::More;

my @result;
my $dates = [
    [ '2019-02-10', '2022-11-01' ],
    [ '2020-09-15', '2022-03-29' ],
    [ '2019-12-31', '2020-01-01' ],
    [ '2019-12-01', '2019-12-31' ],
    [ '2019-12-31', '2020-12-31' ],
    [ '2019-12-31', '2021-12-31' ],
    [ '2020-09-15', '2021-09-16' ],
    [ '2019-09-15', '2021-09-16' ],
];

foreach my $date_pairs ( @$dates ) {
    my @dp1 = split /-/, $date_pairs->[0];
    my @dp2 = split /-/, $date_pairs->[1];

    my $dt1 = DateTime->new( year => $dp1[0], month => $dp1[1], day => $dp1[2], time_zone => 'UTC' );
    my $dt2 = DateTime->new( year => $dp2[0], month => $dp2[1], day => $dp2[2], time_zone => 'UTC' );

    my $years = $dt2->subtract_datetime( $dt1 )->in_units( 'years' );
    my $days  = $dt2->subtract( years => $years )->jd - $dt1->jd;

    push @result, [ $years, $days ];
}

is_deeply(
    [@result],
    [ [ 3, 264 ], [ 1, 195 ], [ 0, 1 ], [ 0, 30 ], [ 1, 0 ], [ 2, 0 ], [ 1, 1 ], [ 2, 1 ] ]
);

done_testing( 1 );
