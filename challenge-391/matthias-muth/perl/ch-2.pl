#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 391 Task 2: Arrange Box
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );

no warnings 'recursion';
sub find_longest_fit( $boxes, $start ) {
    return max( 1,
        map 1 + find_longest_fit( $boxes, $_ ),
            grep {
                $boxes->[$_][0] > $boxes->[$start][0]
                    && $boxes->[$_][1] > $boxes->[$start][1]
            } $start + 1 .. $boxes->$#*
    );
}

use Memoize qw( memoize flush_cache );
memoize( 'find_longest_fit' );

sub arrange_box_recursive( @boxes ) {
    @boxes = sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] } @boxes;
    flush_cache( 'find_longest_fit' );
    return max( map { find_longest_fit( \@boxes, $_ ) } keys @boxes ) // 0;
}

sub arrange_box ( @boxes ) {
    @boxes = sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] } @boxes;
    my @path_lengths = ( 1 ) x @boxes;
    for my $current ( keys @boxes ) {
        for my $other ( $current + 1 .. $#boxes ) {
            $path_lengths[$other] = $path_lengths[$current] + 1
                if $boxes[$other][0] > $boxes[$current][0]
                    && $boxes[$other][1] > $boxes[$current][1]
                    && $path_lengths[$current] + 1 > $path_lengths[$other];
        }
    }
    return max( @path_lengths ) // 0;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [[1, 3], [3, 5], [6, 8], [2, 4]], 4 ],
    [ "Example 2", [[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]], 3 ],
    [ "Example 3", [[5, 5], [5, 5], [5, 5]], 1 ],
    [ "Example 4", [[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]], 4 ],
    [ "Example 5", [[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]], 3 ],
);

is arrange_box( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
