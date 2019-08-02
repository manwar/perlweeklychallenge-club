#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 54;

my %base35_tests = (
    '1a2b3c'    => 67627467,
    '7c5'       => 9000,
    0           => 0,
    1           => 1,
    35          => 110,
    42          => 142,
    9000        => 385875,
    987654321   => 20794783559621,
    ACSE        => 444444,
    Perl5       => 38149690,
    abc         => 12647,
    gorydetails => 46091345832744688,
    pony        => 1102114,
    russians    => 1793822399208,
    y           => 34,
    yammy       => 51477754,
    yxwdj       => 52475799,
    yy          => 1224,
);

while ( my ( $i, $o ) = each %base35_tests ) {

    my $r = `perl ch-2.pl -b $i`;
    chomp $r;

    is( $r, $o );

    $r = `perl ch-2.pl -d $o`;
    chomp $r;

    is( $r, lc $i );

    $r = `perl ch-2.pl -d $o -b $i`;
    chomp $r;

    is ( $r, join "\n", map { lc $_ } ($i, $o ) );
}

done_testing 54;
