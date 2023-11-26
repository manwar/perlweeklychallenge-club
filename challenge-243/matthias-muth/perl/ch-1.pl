#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 243 Task 1: Reverse Pairs
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

sub reverse_pairs( @nums ) {
    my $count = 0;
    for my $i ( 0 .. $#nums - 1 ) {
	for my $j ( $i + 1 .. $#nums ) {
	    ++$count
	        if $nums[$i] > 2 * $nums[$j];
	}
    }
    return $count;
}

sub reverse_pairs_reversed_loops( @nums ) {
    my $count = 0;
    for my $j ( 1 .. $#nums ) {
	for my $i ( 0 .. $j - 1 ) {
	    ++$count
	        if $nums[$i] > 2 * $nums[$j];
	}
    }
    return $count;
}

sub reverse_pairs_for( @nums ) {
    my $count = 0;
    for ( my $i = 0; $i <= $#nums - 1; ++$i ) {
	for ( my $j = $i + 1; $j <= $#nums; ++$j ) {
	    ++$count
	        if $nums[$i] > 2 * $nums[$j];
	}
    }
    return $count;
}

sub reverse_pairs_reversed_for( @nums ) {
    my $count = 0;
    for ( my $j = 1; $j <= $#nums; ++$j ) {
	for ( my $i = 0; $i <= $j - 1; ++$i ) {
	    ++$count
	        if $nums[$i] > 2 * $nums[$j];
	}
    }
    return $count;
}

sub reverse_pairs_grep( @nums ) {
    my $count = 0;
    for my $i ( 0 .. $#nums - 1 ) {
        $count += scalar grep { $nums[$i] > 2 * $nums[$_] } $i + 1 .. $#nums; 
    }
    return $count;
}

sub reverse_pairs_reversed_grep( @nums ) {
    my $count = 0;
    for my $j ( 1 .. $#nums ) {
	$count += scalar grep { $nums[$_] > 2 * $nums[$j] } 0 .. $j - 1;
    }
    return $count;
}

my @subs = qw(
    reverse_pairs
    reverse_pairs_reversed_loops
    reverse_pairs_for
    reverse_pairs_reversed_for
);

run_tests( @subs )
    or exit 0;

use Benchmark qw( :all );
my %benchmark_runs =
    map {
	my $sub_name = $_;
	( $sub_name => sub {
	    no strict 'refs';
	    $sub_name->( qw( 1 3 2 3 1 ) );
	    $sub_name->( qw( 2 4 3 5 1 ) );
	} )
    }
    @subs;


say "\nRunning benchmarks:";
cmpthese -3, \%benchmark_runs;

exit 0;
