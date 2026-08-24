#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

sub get_smallest ($arr) {
    return [] if !@$arr;

    my @return_array = (0);
    my $min          = $arr->[0];

    for my $i ( 1 .. $#$arr ) {
        if ( $min < $arr->[$i] ) {
            push @return_array, $min;
        }
        else {
            push @return_array, 0;
        }

        $min = $arr->[$i] if $arr->[$i] < $min;
    }

    return \@return_array;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is_deeply(
        get_smallest( [ 7, 8, 3, 12, 10 ] ),
        [ 0, 7, 0, 3, 3 ],
        'Example 1'
    );
    is_deeply( get_smallest( [ 4, 6, 5 ] ), [ 0, 4, 4 ], 'Example 2' );
    is_deeply( get_smallest( [5] ),         [0],         'Single element' );
    is_deeply( get_smallest( [] ),          [],          'Empty array' );

    done_testing();
}

