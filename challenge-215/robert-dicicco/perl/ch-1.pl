#!/usr/bin/enc perl
=begin pod
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-01
Challenge 215 Odd One Out ( Perl )
----------------------------------------
=cut
use strict;
use warnings;
use feature 'say';

my @words = (["abc", "xyz", "tsu"],["rat", "cab", "dad"],["x", "y", "z"]);

for my $wds (@words) {
    my $cnt = 0;
    say "Input: \@words = (@$wds)";
    for my $w (@$wds) {
        my $w_sorted = join("",sort(split(//,$w)));
        $cnt++ if ($w ne $w_sorted);
    }
    say "Output: $cnt\n";
}

=begin pod
----------------------------------------
SAMPLE OUTPUT
perl .\OddOneOut.pl
Input: @words = (abc xyz tsu)
Output: 1

Input: @words = (rat cab dad)
Output: 3

Input: @words = (x y z)
Output: 0
----------------------------------------
=cut



