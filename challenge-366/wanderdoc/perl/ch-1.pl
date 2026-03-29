#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of words and a string (contains only lowercase English letters).

Write a script to return the number of words in the given array that are a prefix of the given string.
Example 1

Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
Output: 4

Example 2

Input: @array = ("cat", "dog", "fish"), $str = "bird"
Output: 0

Example 3

Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
Output: 4

Example 4

Input: @array = ("", "code", "coding", "cod"), $str = "coding"
Output: 3

Example 5

Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str = "program"
Output: 7
=cut




use Test2::V0 -no_srand => 1;


is(count_prefixes([("a", "ap", "app", "apple", "banana")], "apple"), 4, "Example 1");
is(count_prefixes([("cat", "dog", "fish")], "bird"), 0, "Example 2");
is(count_prefixes([("hello", "he", "hell", "heaven", "he")], "hello"), 4, "Example 3");
is(count_prefixes([("", "code", "coding", "cod")], "coding"), 3, "Example 4");
is(count_prefixes([("p", "pr", "pro", "prog", "progr", "progra", "program")], "program"), 7, "Example 5");
done_testing();

sub count_prefixes
{
     my ($aref, $str) = @_;
     my @regexes = map qr/^$_/, @$aref;
     my $counter = 0;
     for my $re ( @regexes )
     {
          $counter++ if $str =~ $re;
     }
     return $counter;
}
