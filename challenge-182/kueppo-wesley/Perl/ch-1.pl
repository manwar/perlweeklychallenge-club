#!/usr/bin/env perl

use strict;
use warnings;
use feature      qw(signatures);
use experimental qw(for_list);
use builtin      qw(indexed);
no  warnings     qw(experimental::builtin);

use Test::More;

sub first_max ( $string ) {
    my @array = split m/, |\n/, $string;
    my ( $index, $biggest ) = each @array;

    foreach my ( $i, $v ) ( indexed @array ) {
        if ( $v > $biggest ) {
            $index   = $i;
            $biggest = $v;
        }
    }

    return $index;
}

my $biggest;
push $biggest->@*, first_max $_ foreach <DATA>;

is_deeply( $biggest, [ 2, 1, 4, 4 ], "find the index of the first biggest number in the list" );

done_testing( 1 );

__DATA__
5, 2, 9, 1, 9, 6
5, 10, 9, 1, 10, 6
4, 2, 3, 1, 5, 0
4, 2, 3, 1, 20, 20
