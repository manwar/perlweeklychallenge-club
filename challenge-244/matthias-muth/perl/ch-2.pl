#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 244 Task 2: Group Hero
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

use List::Util qw( min max sum );

my $n_calls = 0;

sub power( @nums ) {
    ++$n_calls;
    return $nums[0] * $nums[-1] ** 2;
}

sub combinations( @nums ) {
    return [ @nums ]
	if @nums <= 1;

    my @rest_combinations = combinations( @nums[ 1..$#nums ] );
    return (
	[ $nums[0] ],
	@rest_combinations,
	map( [ $nums[0], $_->@* ], @rest_combinations ),
    );
}

sub group_hero( @nums ) {
    # We only need to sort the array once.
    @nums = sort { $a <=> $b } @nums;
    $n_calls = 0;
    my $sum = sum( map power( $_->@* ), combinations( @nums ) );
    say "number of calls: $n_calls";
    return $sum;
}

sub power_sum( @nums ) {
    vsay "power_sum( @nums )";
    return 0
	if @nums == 0;
    if ( @nums == 1 ) {
	my $sum = power( @nums );
	vsay "    returning $sum for (@nums)";
	return $sum;
    }

    my $n = @nums;
    my $sum = 0;

    # Assume the numbers are sorted.
    # This means that the first and the last value are the minimum and maximum.

    # If we choose any two entries as the minimum and maximum values,
    # the 'power' of the range including these values does not depend on
    # any of the values in between being present or not.
    # There are 2**(n-2) possible combinations of these 'inner' values.

    # Change the minimum value, going through all possible values,
    # keeping the maximum vaue the same.
    # Avoid min and max being the same, so that the number of 'inner' values
    # doesn't get negative..
    my ( $min_value, $max_value ) = @nums[ 0, -1 ];
    for my $min_entry ( 0 .. $#nums ) {
	my $range_length = $n - $min_entry;
	my $n_inner_values = $range_length >= 2 ? $range_length - 2 : 0;
	my $n_inner_combinations = 1 << $n_inner_values;
	my $add = 
	    power( $nums[$min_entry], $max_value ) * $n_inner_combinations;
	vsay "adding $add for (@nums[$min_entry..$#nums])",
	    " n_inner_values:$n_inner_values";
	$sum += $add;
    }

    # The same for all possible maximum values.
    for my $max_entry ( 0 .. $#nums - 1 ) {
	my $range_length = $max_entry + 1;
	my $n_inner_values = $range_length >= 2 ? $range_length - 2 : 0;
	my $n_inner_combinations = 1 << $n_inner_values;
	my $add = 
	    power( $min_value, $nums[$max_entry] ) * $n_inner_combinations;
	vsay "adding $add for (@nums[0..$max_entry])",
	    " n_inner_values:$n_inner_values";
	$sum += $add;
    }

    # Add the powers of all 'inner' combinations, using a recursive call..
    $sum += power_sum( @nums[ 1 .. $#nums - 1 ] );
    vsay "    returning total sum $sum";
    return $sum;
}

sub group_hero_2( @nums ) {
    # We only need to sort the array once.
    @nums = sort { $a <=> $b } @nums;
    $n_calls = 0;
    my $sum = power_sum( @nums );
    say "number of calls: $n_calls";
    return $sum;
}

my @subs = qw(
    group_hero
    group_hero_2
);
run_tests @subs;

__DATA__
Test 1:
Input: @nums = ( 5,4,2,1 )
Output: 566

Test 2:
Input: @nums = ( 6,5,4,2,1 )
Output: 1826

Test 3: 10 numbers
Input: @nums = ( 1..10 )
Output: 169593

Test 4: 16 numbers
Input: @nums = ( 1..16 )
Output: 29751842

Test 4: 20 numbers
Input: @nums = ( 1..20 )
Output: 761263300

