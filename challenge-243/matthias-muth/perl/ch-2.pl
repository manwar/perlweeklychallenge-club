#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 243 Task 2: Floor Sum
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

use List::Util qw( sum );

sub floor_sum( @nums ) {
    my $count = 0;
    for my $i ( 0..$#nums ) {
	for my $j ( 0..$#nums ) {
	    $count += int( $nums[$j] / $nums[$i] );
	}
    }
    return $count;
}

sub floor_sum_grep( @nums ) {
    my $count = 0;
    for my $i ( 0..$#nums ) {
	$count += sum( map int( $nums[$_] / $nums[$i] ), 0..$#nums );
    }
    return $count;
}

sub floor_sum_half_matrix( @nums ) {
    @nums = sort { $a <=> $b } @nums;
    my $count = 0;
    for my $i ( 0 .. $#nums - 1 ) {
	# Loop over larger or equal values only.
	for my $j ( $i + 1 .. $#nums ) {
	    # Add 2 if the values are equal,
	    # because each of $a/$b and $b/$a is 1.
	    $count += $nums[$j] == $nums[$i] ? 2 : int( $nums[$j] / $nums[$i] );
	}
    }
    # Add 1 for each field in the diagonal.
    return $count + scalar @nums;
}

sub floor_sum_half_matrix_reversed( @nums ) {
    @nums = sort { $a <=> $b } @nums;
    my $count = 0;
    for my $j ( 1 .. $#nums ) {
	# Loop over larger or equal values only
	# (half the matrix, without the diagonal).
	for my $i ( 0 .. $j - 1 ) {
	    # Add 2 for equal values,
	    # because each of n(i) / n(j) and # n(j) / n(i) is 1.
	    $count += $nums[$j] == $nums[$i] ? 2 : int( $nums[$j] / $nums[$i] );
	}
    }
    # Add 1 for each field in the diagonal.
    return $count + scalar @nums;
}

my @subs = qw(
    floor_sum
    floor_sum_half_matrix
    floor_sum_half_matrix_reversed
);

run_tests( @subs )
    or exit 0;

use Benchmark qw( :all );
my %benchmark_runs =
    map {
	my $sub_name = $_;
	( $sub_name => sub {
	    no strict 'refs';
	    $sub_name->( qw( 2 5 9 ) );
	    $sub_name->( ( 7 ) x 7 );
	} )
    }
    @subs;


say "\nRunning benchmarks:";
cmpthese -10, \%benchmark_runs;

exit 0;
