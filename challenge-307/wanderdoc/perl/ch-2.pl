#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of words, @words.

Write a script to find any two consecutive words and if they are anagrams, drop the first word and keep the second. You continue this until there is no more anagrams in the given list and return the count of final list.
Example 1

Input: @words = ("acca", "dog", "god", "perl", "repl")
Output: 3

Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god" => ("acca", "god", "perl", "repl")
Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl" => ("acca", "god", "repl")

Example 2

Input: @words = ("abba", "baba", "aabb", "ab", "ab")
Output: 2

Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba" => ("baba", "aabb", "ab", "ab")
Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb" => ("aabb", "ab", "ab")
Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab" => ("aabb", "ab")

=cut

use List::Util qw(uniq);
use Test2::V0 -no_srand => 1;

is(reduce_anagrams("acca", "dog", "god", "perl", "repl"), 3, 'Example 1');
is(reduce_anagrams("abba", "baba", "aabb", "ab", "ab"), 2, 'Example 2');
done_testing();

sub reduce_anagrams
{
     my @arr = uniq(map { make_standard($_) }  @_);
     return scalar @arr;
}

sub make_standard
{
     my $str = $_[0];
     return join('', sort { $a cmp $b } split(//, lc $str));
}