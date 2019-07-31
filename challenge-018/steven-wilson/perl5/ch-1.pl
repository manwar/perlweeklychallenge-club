#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-22
# Week: 018
#
# Task #1
# Write a script that takes 2 or more strings as command line parameters
# and print the longest common substring. For example, the longest
# common substring of the strings “ABABC”, “BABCA” and “ABCBA” is string
# “ABC” of length 3. Other common substrings are “A”, “AB”, “B”, “BA”,
# “BC” and “C”. Please check this wiki page for details.

use strict;
use warnings;
use feature qw/ say /;

# my @input_strings = @ARGV;
# print_longest_common_string(@input_strings);

my @input_strings = qw/ ABABC BABCA ABCBA /;
print_longest_common_string(@input_strings);

sub print_longest_common_string {
    my @strings = @_;

    # longest strings first
    my @sorted_strings = sort { length $b <=> length $a } @strings;

    my %longest_common_substrings
        = map { $_ => 1 } all_substrings( shift @sorted_strings );

    while (@sorted_strings) {
        %longest_common_substrings = map { $_ => 1 }
            grep { exists $longest_common_substrings{$_} }
            all_substrings( shift @sorted_strings );
    }

    my @sorted_common_strings
        = sort { length $b <=> length $a } keys %longest_common_substrings;

    if (@sorted_common_strings) {
        my $longest_common_substring_length
            = length $sorted_common_strings[0];
        say "Longest common substring(s): " . join " ",
            grep { length $_ == $longest_common_substring_length }
            @sorted_common_strings;
    }
    else {
        say "No common substrings exist";
    }
    return;
}

sub all_substrings {
    my $string        = shift;
    my $string_length = length $string;
    my %substrings;
    for ( my $i = 0; $i <= $string_length - 1; $i++ ) {
        for ( my $j = ($string_length) - ($i); $j > 0; $j-- ) {
            $substrings{ substr $string, $i, $j } = 1;
        }
    }
    my @sorted_substrings = sort { length $b <=> length $a } keys %substrings;
    return @sorted_substrings;
}
