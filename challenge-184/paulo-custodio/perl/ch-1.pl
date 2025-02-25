#!/usr/bin/env perl

# Challenge 184
#
# Task 1: Sequence Number
# Submitted by: Mohammad S Anwar
#
# You are given list of strings in the format aa9999 i.e. first 2 characters can
# be anything 'a-z' followed by 4 digits '0-9'.
#
# Write a script to replace the first two characters with sequence starting with
# '00', '01', '02' etc.
# Example 1
#
# Input: @list = ( 'ab1234', 'cd5678', 'ef1342')
# Output: ('001234', '015678', '021342')
#
# Example 2
#
# Input: @list = ( 'pq1122', 'rs3334')
# Output: ('001122', '013334')

use Modern::Perl;

sub sequence {
    my(@in) = @_;
    my %keys;
    @in = map {/([a-z]+)(\d+)/ and [$1, $2]} @in;
    for (@in) { $keys{$_->[0]}=0; }
    my $id = 0; for (sort keys %keys) { $keys{$_} = $id++; }
    @in = sort map {sprintf("%02d%s", $keys{$_->[0]}, $_->[1])} @in;
    return @in;
}

@ARGV or die "usage: ch-1.pl list...\n";
say join " ", sequence(@ARGV);
