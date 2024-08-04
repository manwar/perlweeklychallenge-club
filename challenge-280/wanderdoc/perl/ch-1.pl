#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str, containing lowercase English letters only.

Write a script to print the first letter that appears twice.
Example 1

Input: $str = "acbddbca"
Output: "d"

Example 2

Input: $str = "abccd"
Output: "c"

Example 3

Input: $str = "abcdabbb"
Output: "a"

=cut


use Test2::V0;
is(first_letter_twice(q[acbddbca]), 'd', 'Example 1');
is(first_letter_twice(q[abccd]), 'c', 'Example 2');
is(first_letter_twice(q[abcdabbb]), 'a', 'Example 3');
done_testing();

sub first_letter_twice
{
     my $str = $_[0];
     my %counter;
     for my $chr ( split(//, $str) )
     {
          if ( exists $counter{$chr} )
          {
               return $chr;
          }
          else
          {
               $counter{$chr} = undef;
          }
     }
     return 0; # if no letter appears twice.
}