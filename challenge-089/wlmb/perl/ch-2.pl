#!/usr/bin/env perl
# Perl weekly challenge 89
# Challenge 2.
# Magical matrix. Build a 3x3 matrix so that the sums of all rows, columns and diagonals is 15

# Load packages
use warnings;
use strict;
use v5.10;

# generate all permutations of a set using a callback function to test each
# permutation. Stop when callback returns success (true) or when no more permutations
# I use this technique to avoid storing all 9! permutations in
# memory. With a callback I can generate them and test them one at a time.

sub permutations {
    my ($callback, $all_flag, @set)=@_;
    permutations_ancillary($callback, $all_flag, [], [@set]); #use auxiliary function
}

# Append the permutations of @$rest to @$first and call the callback
# when a permutation is completed. Continue generating permutations
# until success or until no more  permutations. Returns success
# The idea is to fix the first element and recursively permute the
# rest. Then change the first element and iterate.
sub permutations_ancillary {
    my $callback=shift; # callback function
    my $all_flag=shift; # flag to generate all magical matrices
    my @first=@{shift @_}; # first elements
    my @rest=@{shift @_};  # elements to permute
    return $callback->($all_flag, @first) unless @rest; # finished?
    foreach (0..$#rest){
	# choose one element to add to first and permute the rest
	my @new_first=@first;
	my @new_rest=@rest;
	push @new_first, splice @new_rest, $_, 1;
	my $success=permutations_ancillary($callback, $all_flag, [@new_first], [@new_rest]);
	return $success if $success;
    }
}

# Test if a permutation of 1..9 corresponds to a Magic Square
sub test_magic {
    use PDL; #Use perl data language to simplify coding matrix operations
    use PDL::NiceSlice;
    my $all_flag=shift;
    my $square=pdl(@_)->reshape(3,3); # turn array into pdl square matrix
    my $ok=    all($square->sumover==15)                    # check sum of rows
	    && all($square->transpose->sumover==15)         # of columns
	    && $square->diagonal(0,1)->sumover==15          # of main diagonal
            && $square->(-1:0)->diagonal(0,1)->sumover==15; # and of inverted diagonal
    if($ok){
	say $square;
	return !$all_flag; # replace 1 by 0 to generate all magical matrices.
    }
    return 0;
}

# Test
say "Generate one magical matrix";
permutations(\&test_magic, 0, 1..9);

say "Generate all magical matrices";
permutations(\&test_magic, 1, 1..9);
#Output

# Generate one magical matrix
#
# [
#  [2 7 6]
#  [9 5 1]
#  [4 3 8]
# ]
#
# Generate all magical matrices
#
# [
#  [2 7 6]
#  [9 5 1]
#  [4 3 8]
# ]
#
#
# [
#  [2 9 4]
#  [7 5 3]
#  [6 1 8]
# ]
#
#
# [
#  [4 3 8]
#  [9 5 1]
#  [2 7 6]
# ]
#
#
# [
#  [4 9 2]
#  [3 5 7]
#  [8 1 6]
# ]
#
#
# [
#  [6 1 8]
#  [7 5 3]
#  [2 9 4]
# ]
#
#
# [
#  [6 7 2]
#  [1 5 9]
#  [8 3 4]
# ]
#
#
# [
#  [8 1 6]
#  [3 5 7]
#  [4 9 2]
# ]
#
#
# [
#  [8 3 4]
#  [1 5 9]
#  [6 7 2]
# ]
