#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of strings.

Write a script to return all strings that are a substring of another word in the given array in the order they occur.
Example 1

Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")
Output: ("cat", "dog", "dogcat", "rat")


Example 2

Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
Output: ("hell", "world", "wor", "ellow")


Example 3

Input: @words = ("a", "aa", "aaa", "aaaa")
Output: ("a", "aa", "aaa")


Example 4

Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
Output: ("flow", "fl", "fli", "ig", "ght")


Example 5

Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
Output: ("car", "pet", "enter", "pen", "pent")

=cut


use List::Util qw(first uniq);
use Test2::V0 -no_srand => 1;

is([match_string("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")],
     [("cat", "dog", "dogcat", "rat")], 'Example 1');

is([match_string("hello", "hell", "world", "wor", "ellow", "elloworld")],
     [("hell", "world", "wor", "ellow")], 'Example 2');

is([match_string("a", "aa", "aaa", "aaaa")],
     [("a", "aa", "aaa")], 'Example 3');

is([match_string("flower", "flow", "flight", "fl", "fli", "ig", "ght")],
     [("flow", "fl", "fli", "ig", "ght")], 'Example 4');

is([match_string("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")],
     [("car", "pet", "enter", "pen", "pent")], 'Example 5');

done_testing;


sub match_string
{
     my @arr = @_;
     my @output;
     for my $word (@arr)
     {
          if ( defined first 
               { 
                    $_ ne $word and
                    index($_, $word) != -1 
               } @arr )
          {
               push @output, $word;
          }
     }
     @output = uniq @output;
     return @output;
}
