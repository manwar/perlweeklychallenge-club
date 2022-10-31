#!/usr/bin/env perl
package challenge189::ch2;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(reduce max);

use Test::More tests => 6;

is_deeply( array_degree( [ 1, 3, 3, 2 ] ), [ 3, 3 ], 'Example 1' );
is_deeply( array_degree( [ 1, 2, 1, 3 ] ), [ 1, 2, 1 ], 'Example 2' );
is_deeply( array_degree( [ 1, 3, 2, 1, 2 ] ), [ 2, 1, 2 ], 'Example 3' );
is_deeply( array_degree( [ 1, 1, 2, 3, 2 ] ), [ 1, 1 ], 'Example 4' );
is_deeply( array_degree( [ 2, 1, 2, 1, 1 ] ), [ 1, 2, 1, 1 ], 'Example 5' );
is_deeply(
    array_degree( [ 1, 1, 2, 1, 1 ] ),
    [ 1, 1, 2, 1, 1 ],
    'My Example 1 (whole array)'
);

sub array_degree($array) {
    reduce(
        sub {
            my $current_degree = degree($b);
            if ( $current_degree > $a->{degree}
                || ( $current_degree == $a->{degree} && $b->@* < $a->{res}->@* )
              )
            {
                return {
                    degree => $current_degree,
                    res    => $b,
                };
            }

            return $a;

        },
        { degree => 0, res => [] },
        subarrays($array)
    )->{res};
}

sub subarrays($array) {
    my @out;

    my $go;
    $go = sub ( $start, $end ) {
        if ( $end >= $array->@* ) {
            return;
        }

        if ( $start > $end ) {
            return $go->( 0, $end + 1 );
        }

        push @out, [ @{$array}[ $start .. $end ] ];
        return $go->( $start + 1, $end );

    };

    $go->( 0, 0 );

    return @out;
}

sub degree($array) {
    my %elems;
    map { $elems{$_}++ } $array->@*;
    return max( values %elems );
}
