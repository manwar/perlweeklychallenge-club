#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 233 Task 2: Frequency Sort
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

sub frequency_sort_core( @ints ) {

    # We need the frequencies for sorting. So let's compute them...
    my %frequencies;
    ++$frequencies{$_}
        for @ints;

    # Let 'sort' do the work, with the comparison code block representing
    # how we want things to be sorted.
    return sort { $frequencies{$a} <=> $frequencies{$b} || $b <=> $a } @ints;
}

run_tests;

=for benchmark

sub frequency_sort_core( $ints ) {
    my %frequencies;
    ++$frequencies{$_}
        for @$ints;
    return scalar %frequencies;
}

use List::MoreUtils qw( frequency );

sub frequency_sort_moreutils( $ints ) {
    my %frequencies = frequency @$ints;
    return scalar %frequencies;
}

use Benchmark qw( :all );

sub gen_ints( $n ) {
    return map rand() * $n, 1..$n;
}

$| = 1;

for ( qw( 10 100 1000 10000 100000 ) ) {
    my @ints = gen_ints( $_ );

    cmpthese( -1, {
	"core $_"  => sub { my @a = frequency_sort_core( \@ints ) },
	"utils $_" => sub { my @a = frequency_sort_moreutils( \@ints ) },
    } );
}

=cut
