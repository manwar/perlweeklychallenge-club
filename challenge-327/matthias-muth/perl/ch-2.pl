#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 327 Task 2: MAD
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( min );

sub mad( @ints ) {
    @ints = sort { $a <=> $b } @ints;
    my @diffs = map $ints[ $_ + 1 ] - $ints[$_], 0..( $#ints - 1 );
    my $min_diff = min @diffs;
    return
        map [ @ints[ $_, $_ + 1 ] ],
            grep $diffs[$_] == $min_diff,
                keys @diffs;
}

sub mad_pairs( @ints ) {
    @ints = sort { $a <=> $b } @ints;
    my @pairs = map [ @ints[ $_, $_ + 1 ] ], 0 .. $#ints - 1;
    my @diffs = map $_->[1] - $_->[0], @pairs;
    my $min_diff = min( @diffs );
    return map $pairs[$_], grep $diffs[$_] == $min_diff, keys @diffs;
}

use List::MoreUtils qw( slide );

sub mad_slide( @ints ) {
    @ints > 1 or return ();
    my @pairs = slide { [ $a, $b ] } sort { $a <=> $b } @ints;
    my @diffs = map $_->[1] - $_->[0], @pairs;
    my $min_diff = min( @diffs );
    return map $pairs[$_], grep $diffs[$_] == $min_diff, keys @diffs;
}

use Test2::V0 qw( -no_srand );

is [ mad() ], [],
    'Test 1: empty list';
is [ mad( 5 ) ], [],
    'Test 2: one element only';
is [ mad( 4, 1, 2, 3 ) ], [ [1, 2], [2, 3], [3, 4] ],
    'Example 1: mad( 4, 1, 2, 3 ) == ([1, 2], [2, 3], [3, 4])';
is [ mad( 1, 3, 7, 11, 15 ) ], [ [1, 3] ],
    'Example 2: mad( 1, 3, 7, 11, 15 ) == [1, 3]';
is [ mad( 1, 5, 3, 8 ) ], [ [1, 3], [3, 5] ],
    'Example 3: mad( 1, 5, 3, 8 ) == ([1, 3], [3, 5])';

done_testing;

use Benchmark qw( cmpthese );

my @ints = ( 1, 3, 7, 11, 15 );
cmpthese -3, {
    indices => sub { my @results = mad( @ints ); },
    pairs   => sub { my @results = mad_pairs( @ints ); },
    slide   => sub { my @results = mad_slide( @ints ); },
};
