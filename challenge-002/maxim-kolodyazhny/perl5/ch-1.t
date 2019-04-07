#!/usr/bin/env perl

use strict;
use warnings;

use v5.28;

use Test::More tests => 10;

my %tests = (
    '-0.04'    =>  '-0.04',
    '-000.000' =>  '-0.000',
    '.0001'    => '.0001',
    '0.0001'   => 0.0001,
    0          => 0,
    000000000  => 0,
    007        => 7,
    0102030405 =>  0102030405,
    1000001    =>  1000001,
    42         => 42,
    667        => 667,
);

while ( my ( $i, $o ) = each %tests ) {

    my $r = `echo $i | bash ./ch-1.sh`;
    chomp $r;

    is( $r, $o );
}

done_testing 10;
