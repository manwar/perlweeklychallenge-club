#!/usr/bin/env perl

use Modern::Perl '2020';
use experimental 'signatures';
use Data::Printer;

# TASK #1 › Common Base String
# Submitted by: Mohammad S Anwar
# You are given 2 strings, $A and $B.

# Write a script to find out common base strings in $A and $B.

# A substring of a string $S is called base string if repeated concatenation of the substring results in the string.

# Example 1:
# Input:
#     $A = "abcdabcd"
#     $B = "abcdabcdabcdabcd"

# Output:
#     ("abcd", "abcdabcd")
# Example 2:
# Input:
#     $A = "aaa"
#     $B = "aa"

# Output:
#     ("a")

sub base_strings($S)
{
    my @result;
    for my $l ( 1 .. length $S ) {
        my $substr = substr( $S, 0, $l );
        next unless $S =~ /^($substr)+?$/;
        push @result, $substr;
    }
    return @result;
}

my %base_strings;
for my $S (@ARGV) {
    my @b = base_strings($S);
    $base_strings{$_}++ for @b;
}

my @common_base_strings;
for (keys %base_strings){
    if ($base_strings{$_} == scalar @ARGV) {
        push @common_base_strings, $_;
    }
}

say np @common_base_strings;