#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 322 Task 2: Rank Array
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( indexed );

use List::Util qw( uniq pairs );
use Verbose;

sub rank_array( @ints ) {
    my @uniq = uniq @ints;
    my @sorted = sort { $a <=> $b } @uniq;
    my %ranks = map { ( $sorted[$_] => $_ + 1 ) } keys @sorted; 
    vsay "\@ints:    ", pp @ints;
    vsay "\@uniq:    ", pp @uniq;
    vsay "\@sorted:  ", pp @sorted;
    vsay "\%ranks:   ", pp_hash %ranks;
    my @mappings = map $ranks{$_}, @ints;
    vsay "\@mappings: ", pp @mappings;
    return @mappings;
}

sub rank_array( @ints ) {
    my @uniq_sorted = sort { $a <=> $b } uniq @ints;
    my %ranks = map { ( $uniq_sorted[$_] => $_ + 1 ) } 0..$#uniq_sorted; 
    return map $ranks{$_}, @ints;
}

use Test2::V0 qw( -no_srand );

is [ rank_array( 55, 22, 44, 33 ) ], [ 4, 1, 3, 2 ],
    'Example 1: rank_array( 55, 22, 44, 33 ) == (4, 1, 3, 2)';
is [ rank_array( 10, 10, 10 ) ], [ 1, 1, 1 ],
    'Example 2: rank_array( 10, 10, 10 ) == (1, 1, 1)';
is [ rank_array( 5, 1, 1, 4, 3 ) ], [ 4, 1, 1, 3, 2 ],
    'Example 3: rank_array( 5, 1, 1, 4, 3 ) == (4, 1, 1, 3, 2)';
is [ rank_array( 55, 11, 11, 44, 11, 33 ) ], [ 4, 1, 1, 3, 1, 2 ],
    'Extra 1: rank_array( 55, 11, 11, 44, 11, 33 ) == (4, 1, 1, 3, 1, 2 )';

done_testing;
