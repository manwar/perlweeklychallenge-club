#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use List::Util qw(min);

sub min_window ( $arr, $s ) {
    return [] if !@$arr || $s <= 0;
    return [ min(@$arr) ] if $s >= scalar(@$arr);

    my @return_array;
    for my $i ( 0 .. scalar(@$arr) - $s ) {
        push @return_array, min( @$arr[ $i .. $i + $s - 1 ] );
    }

    return \@return_array;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is_deeply(
        min_window( [ 1, 5, 0, 2, 9, 3, 7, 6, 4, 8 ], 3 ),
        [ 0, 0, 0, 2, 3, 3, 4, 4 ],
        'Example 1'
    );
    is_deeply( min_window( [ 1, 2, 3 ], 4 ), [1], 'Window larger than array' );
    is_deeply( min_window( [ 3, 1, 2 ], 1 ), [ 3, 1, 2 ], 'Window size 1' );
    is_deeply( min_window( [],          3 ), [],        'Empty array' );

    done_testing();
}

