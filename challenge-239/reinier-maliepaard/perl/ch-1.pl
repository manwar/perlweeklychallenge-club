#!/usr/bin/perl
use strict;
use warnings;

sub same_string {
    my($aref_1, $aref_2) = @_;

    (join('', @{$aref_1}) eq join('', @{$aref_2})) ? print("true\n") : print("false\n");
}

# TESTS

# Example 1
my @arr_1 = ("ab", "c");
my @arr_2 = ("a", "bc");
same_string(\@arr_1, \@arr_2); # Output: true

# Example 2
@arr_1 = ("ab", "c");
@arr_2 = ("ac", "b");
same_string(\@arr_1, \@arr_2); # Output: false

# Example 3
@arr_1 = ("ab", "cd", "e");
@arr_2 = ("abcde");
same_string(\@arr_1, \@arr_2); # Output: true
