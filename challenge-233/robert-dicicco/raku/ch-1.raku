#!/usr/bin/env raku
=begin comment
AUTHOR: Robert DiCicco
DATE  : 2023-09-09
Challenge 233 Task one Similar Words ( Raku )
=end comment

#my @words = ("aba", "aabb", "abcd", "bac", "aabc");
my @words = ("aabb", "ab", "ba");

my $pairs = 0;
my $cnt = 1;
say "Input: \@words = ",@words;

for @words.combinations(2) {             # for each combination of size 2
    my @arr = split(" ",$_);
    my $srt1 = @arr[0].comb.unique.sort.join;
    my $srt2 = @arr[1].comb.unique.sort.join;
    if $srt1 eq $srt2 {
        say "\tpair$cnt \[@arr[0] @arr[1]\]";
        $pairs++;
        $cnt++;
    }
}

say "Output: $pairs";

=begin comment
SAMPLE OUTPUT
raku .\SimilarWords.rk

Input: @words = [aba aabb abcd bac aabc]
        pair1 [aba aabb]
        pair2 [bac aabc]
Output: 2

raku .\SimilarWords.rk
Input: @words = [aabb ab ba]
        pair1 [aabb ab]
        pair2 [aabb ba]
        pair3 [ab ba]
Output: 3
=end comment
