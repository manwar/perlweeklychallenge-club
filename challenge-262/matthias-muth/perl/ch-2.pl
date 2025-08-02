#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 262 Task 2: Count Equal Divisible
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( product );

sub count_equal_divisible( $ints, $k ) {
    my %indices;
    for my $index ( 0..$ints->$#* ) {
	push $indices{ $ints->[$index] }->@*, $index;
    }
    my $count = 0;
    for my $number ( sort { $a <=> $b } keys %indices ) {
	say "number $number indices: $indices{$number}->@*";
	next
	    if $indices{$number}->@* < 2;
	my $last_i_index = $indices{$number}->$#* - 1;
	my $last_j_index = $indices{$number}->$#*;
	say "    i: 0..$last_i_index";
	say "    j: i+1..$last_j_index";
	for my $i_index ( 0..$last_i_index ) {
	    my $i = $indices{$number}[$i_index];
	    for my $j_index ( $i_index + 1 .. $last_j_index ) {
		my $j = $indices{$number}[$j_index];
		my $is_divisible = ( $i * $j ) % $k == 0;
		say "    ", "checking (i,j) == ($i,$j): ",
		    $i * $j, " is ",
		    $is_divisible ? "" : "not ", "divisible by $k";
		++$count
		    if $is_divisible;
	    }
	}
    }
    return $count;
}

use Test2::V0 qw( -no_srand );
is count_equal_divisible( [3, 1, 2, 2, 2, 1, 3], 2 ), 4,
    'Example 1: count_equal_divisible( [3, 1, 2, 2, 2, 1, 3], 2 ) == 4';
is count_equal_divisible( [1, 2, 3], 1 ), 0,
    'Example 2: count_equal_divisible( [1, 2, 3], 1 ) == 0';
done_testing;
