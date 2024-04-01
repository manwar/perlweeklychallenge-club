#!/usr/bin/env perl
#
# You are given a paragraph $p and a banned word $w.
# 
# Write a script to return the most frequent word that is not banned.
# Example 1
# 
# Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
#        $w = "hit"
# Output: "ball"
# 
# The banned word "hit" occurs 3 times.
# The other word "ball" occurs 2 times.
# 
# Example 2
# 
# Input: $p = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
#        $w = "the"
# Output: "Perl"
# 
# The banned word "the" occurs 3 times.
# The other word "Perl" occurs 2 times.
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["Joe hit a ball, the hit ball flew far after it was hit.", "hit"],
    [ "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the"],
];

sub most_frequent_word
{
    my ($p, $w) = @_;

    $p =~ s/[^a-z\s]//gi; # keep letters only
    my @w = split(/\s/, $p);
    my %stat;
    for (@w) {
        ++$stat{$_} unless $_ eq $w;
    }

    return (sort {$stat{$b} <=> $stat{$a}} keys %stat)[0];
}

is(most_frequent_word($cases->[0]->@*), 'ball',  'Example 1');
is(most_frequent_word($cases->[1]->@*), 'Perl',  'Example 2');
done_testing();

exit 0;

         
