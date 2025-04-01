#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of words and a character.
Write a script to return the index of word in the list where you find the given character.
Example 1

Input: @list = ("the", "weekly", "challenge")
       $char = "e"
Output: (0, 1, 2)

Example 2

Input: @list = ("perl", "raku", "python")
       $char = "p"
Output: (0, 2)

Example 3

Input: @list = ("abc", "def", "bbb", "bcd")
       $char = "b"
Output: (0, 2, 3)
=cut

use Test2::V0 -no_srand => 1;
is(find_words(["the", "weekly", "challenge"], "e"), [0, 1, 2], 'Example 1');
is(find_words(["perl", "raku", "python"], "p"), [0, 2], 'Example 2');
is(find_words(["abc", "def", "bbb", "bcd"], "b"), [0, 2, 3], 'Example 3');

done_testing();

sub find_words
{
     my ($words_aref, $char) = @_;
     return [grep { $words_aref->[$_] =~ /$char/ } 
               0 .. $#$words_aref];
}
