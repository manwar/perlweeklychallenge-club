#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string made up of lower and upper case English letters only.
Write a script to return the good string of the given string. A string is called good string if it doesn't have two adjacent same characters, one in upper case and other is lower case.

Example 1

Input: $str = "WeEeekly"
Output: "Weekly"

We can remove either, "eE" or "Ee" to make it good.


Example 2

Input: $str = "abBAdD"
Output: ""

We remove "bB" first: "aAdD"
Then we remove "aA": "dD"
Finally remove "dD".


Example 3

Input: $str = "abc"
Output: "abc"
=cut

use Test2::V0 -no_srand => 1;

is(make_good_string("WeEeekly"), "Weekly", "Example 1");
is(make_good_string("abBAdD"), "", "Example 2");
is(make_good_string("abc"), "abc", "Example 3");
done_testing();


sub make_good_string
{
     my $str = $_[0];
     my @arr = split(//, $str);
     LOOP: while ( 1 )
     {
          return '' unless @arr;
          for my $idx ( 0 .. $#arr - 1 )
          {
               if ( ord($arr[$idx]) - ord($arr[$idx+1]) == 32 
                     or
                    ord($arr[$idx+1]) - ord($arr[$idx]) == 32 
                  )
               {
                    splice(@arr, $idx, 2);
                    next LOOP;
               }
          }
          return join('', @arr);
     }
}
