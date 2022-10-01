#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my ( $n, $v ) = -1;

map {
    $n++;
    map { push $v->{ m/\d/ ? 'digit' : 'chr' }[ $n ]->@*, $_ } split
} ( "a 1 2 b 0", "3 c 4 d" );

is_deeply( $v->{digit}, [ [ 1, 2, 0 ], [ 3, 4 ] ], "extracted digits?" );
is_deeply( $v->{chr}, [ [ 'a', 'b' ], [ 'c', 'd' ] ], "extracted characters?" );

done_testing( 2 );
