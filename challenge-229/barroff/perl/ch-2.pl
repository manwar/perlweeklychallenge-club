#!/usr/bin/env perl

use v5.38;

use List::Util qw( uniq );

sub two_out_of_three ( $array1, $array2, @array3 ) {
    my %elements;
    map { $elements{$_}++ } uniq(@$array1), uniq(@$array2), uniq(@array3);
    my @result = sort grep { $elements{$_} > 1 } keys %elements;
    return \@result;
}

sub MAIN() {

    #| Run test cases
    use Test2::V0 qw( is plan );
    plan 2;

    is two_out_of_three( [ 1, 1, 2, 4 ], [ 2, 4 ], ( 4, ) ), [ 2, 4 ],
      'works for ( [ 1, 1, 2, 4 ], [ 2, 4 ], ( 4, ) )';
    is two_out_of_three( [ 4, 1 ], [ 2, 4 ], ( 1, 2 ) ), [ 1, 2, 4 ],
      'works for ( [ 4, 1 ], [ 2, 4 ], ( 1, 2 ) )';
}

MAIN();
