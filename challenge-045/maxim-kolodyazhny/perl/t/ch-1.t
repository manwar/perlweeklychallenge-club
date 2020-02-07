#!/usr/bin/env perl

use strict;
use warnings;
use FindBin qw($Bin);

use Test::More tests => 8;

my %s = (
    '1 2'       => '1 2',
    '1'         => '1',
    '123'       => '1 2 3',
    '12345678' => '1 2 3 4 5 6 7 8',
    '123456789' => '19 2 3 4 5 6 7 8',
    '1234567890' => '19 20 3 4 5 6 7 8',
    'The quick brown fox jumps over the lazy dog' => 'tbjrd hruto eomhg qwpe unsl ifoa covz kxey',
    'https://github.com/manwar/perlweeklychallenge-club' => 'hgorelu tim/keb tt/pln phmeyg suarce :bnlh- /.wwac /caell',
);

while ( my ( $s, $r ) = each %s ) {

    my $r2 = `echo '$s'  | perl $Bin/../ch-1.pl`;

    is( $r2, $r );
}
