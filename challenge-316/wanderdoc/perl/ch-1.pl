#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of words.

Write a script to find out whether the last character of each word is the first character of the following word.
Example 1

Input: @list = ("perl", "loves", "scala")
Output: true

Example 2

Input: @list = ("love", "the", "programming")
Output: false

Example 3

Input: @list = ("java", "awk", "kotlin", "node.js")
Output: true
=cut

use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(circular("perl", "loves", "scala"), true, 'Example 1');
is(circular("love", "the", "programming"), false, 'Example 2');
is(circular("java", "awk", "kotlin", "node.js"), true, 'Example 3');
done_testing();

sub circular
{
     my @list = @_;
     for my $idx ( 0 .. $#list - 1 )
     {
          if ( substr($list[$idx], -1) ne substr($list[$idx + 1], 0, 1))
          {
               return false;
          }
     }
     return true;
}
