=begin
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

use strict;
use warnings;
use Data::Dumper;

my @words = (["cat", "bat", "rat"],["a", "b", "c"],["man", "bike"]);

my @sentences =(["the cattle was rattle by the battery"],
                ["aab aac and cac bab"],
                ["the manager was hit by a biker"]);

my @output;

foreach(0..scalar @words-1){
    my @word = @{$words[$_]};
    my $sentence = $sentences[$_][0];

    foreach(@word){
        $sentence =~ s/\b$_\w*\b/$_/g;
    }
    push @output,$sentence;
}

print Dumper @output;