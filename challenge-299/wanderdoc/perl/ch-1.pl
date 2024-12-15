#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of words and a sentence.

Write a script to replace all words in the given sentence that start with any of the words in the given array.
Example 1

Input: @words = ("cat", "bat", "rat")
       $sentence = "the cattle was rattle by the battery"
Output: "the cat was rat by the bat"

Example 2

Input: @words = ("a", "b", "c")
       $sentence = "aab aac and cac bab"
Output: "a a a c b"

Example 3

Input: @words = ("man", "bike")
       $sentence = "the manager was hit by a biker"
Output: "the man was hit by a bike"

=cut

use Test2::V0 -no_srand => 1;

is(replace_words([("cat", "bat", "rat")], 
     "the cattle was rattle by the battery"),
     "the cat was rat by the bat", 'Example 1');
is(replace_words([("a", "b", "c")], 
     "aab aac and cac bab"),
     "a a a c b", 'Example 2');
is(replace_words([("man", "bike")], 
     "the manager was hit by a biker"),
     "the man was hit by a bike", 'Example 3');
done_testing();

sub replace_words
{
     my ($words_aref, $sentence) = @_;
     my $search_parts = join('|', @$words_aref);
     my $search_re = qr/$search_parts/;
     return
          join(' ', map { s/(($search_re).+)/$2/r; } 
          split(/ /, $sentence));
}