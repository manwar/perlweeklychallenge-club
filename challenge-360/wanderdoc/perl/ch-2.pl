#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are give a sentence.

Write a script to order words in the given sentence alphabetically but keeps the words themselves unchanged.
Example 1

Input: $str = "The quick brown fox"
Output: "brown fox quick The"


Example 2

Input: $str = "Hello    World!   How   are you?"
Output: "are Hello How World! you?"


Example 3

Input: $str = "Hello"
Output: "Hello"


Example 4

Input: $str = "Hello, World! How are you?"
Output: "are Hello, How World! you?"


Example 5

Input: $str = "I have 2 apples and 3 bananas!"
Output: "2 3 and apples bananas! have I"

=cut


use Test2::V0 -no_srand => 1;

is(word_sorter("The quick brown fox"),
     "brown fox quick The", 'Example 1');
is(word_sorter("Hello    World!   How   are you?"),
     "are Hello How World! you?", 'Example 2');
is(word_sorter("Hello"),
     "Hello", 'Example 3');
is(word_sorter("Hello, World! How are you?"),
     "are Hello, How World! you?", 'Example 4');
is(word_sorter("I have 2 apples and 3 bananas!"),
     "2 3 and apples bananas! have I", 'Example 5');
done_testing();

sub word_sorter
{
     my $str = $_[0];
     my @words = split(/\s+/, $str);
     return join(' ', sort {lc $a cmp lc $b} @words);
}
