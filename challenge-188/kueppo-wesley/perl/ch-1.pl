#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

sub find_div_pairs {
    my ( $k, $list ) = @_;
    my $count;

    foreach my $x ( 0 .. $#$list - 1 ) {
        $count += grep { ( $list->[ $x ] + $list->[ $_ ] ) % $k == 0 } $x + 1 .. $#$list;
    }

    return $count;
}

### Testing..
my $lists = [
    [ 2, [ 4, 5, 1, 6 ] ],
    [ 2, [ 1, 2, 3, 4 ] ],
    [ 3, [ 1, 3, 4, 5 ] ],
    [ 4, [ 5, 1, 2, 3 ] ],
    [ 4, [ 7, 2, 4, 5 ] ],
];

my $expected = [ 2, 2, 2, 2, 1 ];
my $result;

push @$result, $_ for map { find_div_pairs( @$_ ) } @$lists;
is_deeply( $result, $expected, 'found the pairs?' );

done_testing( 1 );
