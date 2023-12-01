#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 244 Task 1: Count Smaller
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

sub count_smaller( @int ) {
    return
	map {
	    my $n = $_;
	    scalar grep $_ < $n, @int;
	} @int;
}

sub count_smaller_2( @int ) {
    my ( %frequencies, %sum_lower_than );
    ++$frequencies{$_}
	for @int;
    my $count = 0;
    for ( sort { $a <=> $b } keys %frequencies ) {
	$sum_lower_than{$_} = $count;
	$count += $frequencies{$_};
    }
    return map $sum_lower_than{$_}, @int;
}

my @subs = qw( count_smaller count_smaller_2 );

run_tests( @subs )
    or exit 0;

use Benchmark qw( :all );
my %benchmark_runs =
    map {
	my $sub_name = $_;
	( $sub_name => sub {
	    no strict 'refs';
	    $sub_name->( qw( 8 1 2 2 3 ) );
	    $sub_name->( qw( 6 5 4 8 ) );
	    $sub_name->( qw( 2 2 2 ) );
	    $sub_name->( map int( rand() * 1000 ), 1..1000 );
	} )
    }
    @subs;


say "\nRunning benchmarks:";
cmpthese -3, \%benchmark_runs;

exit 0;
