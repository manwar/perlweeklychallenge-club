#!/usr/bin/env perl
=begin comment
AUTHOR: Robert DiCicco
DATE  : 2023-09-09
Challenge 233 Task one Similar Words ( Perl )
=cut

use v5.38;
use List::Util qw/uniq/;
use Algorithm::Combinatorics qw/combinations/;

#my @words = ("aba", "aabb", "abcd", "bac", "aabc");
my @words = ("aabb", "ab", "ba");
my $pairs = 0;
my $cnt = 1;

say "Input: \@words = [@words]";
my $iter = combinations(\@words, 2);
    while (my $c = $iter->next) {
        my $str1 = join("",uniq(sort(split("",@$c[0]))));
        my $str2 = join("",uniq(sort(split("",@$c[1]))));
        if ($str1 eq $str2) {
            say "\tpair$cnt \[@$c[0] @$c[1]\]";
            $pairs++;
            $cnt++;
        }
    }
say("Output: $pairs");

=begin comment
SAMPLE OUTPUT
perl .\SimilarWords.pl

Input: @words = [aba aabb abcd bac aabc]
        pair1 [aba aabb]
        pair2 [bac aabc]
Output: 2

perl .\SimilarWords.pl
Input: @words = [aabb ab ba]
        pair1 [aabb ab]
        pair2 [aabb ba]
        pair3 [ab ba]
Output: 3
=cut
