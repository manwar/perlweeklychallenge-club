#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str, where every two consecutive vertical bars are grouped into a pair.

Write a script to return the number of asterisks, *, excluding any between each pair of vertical bars.
Example 1

Input: $str = "p|*e*rl|w**e|*ekly|"
Ouput: 2

The characters we are looking here are "p" and "w**e".

Example 2

Input: $str = "perl"
Ouput: 0

Example 3

Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
Ouput: 5

The characters we are looking here are "th", "e**", "l***ych" and "e".

=cut

use Test2::V0;

is(count_asterisks(q[p|*e*rl|w**e|*ekly|]), 2, 'Example 1');
is(count_asterisks(q[perl]), 0, 'Example 2');
is(count_asterisks(q[th|ewe|e**|k|l***ych|alleng|e]), 5, 'Example 3');

done_testing();




sub count_asterisks
{
     my $str = $_[0];
     my @chars = split(//, $str);;
     my @filtered;
     my $flag = 0;
     for my $chr ( @chars )
     {
          if ( $chr eq '|' )
          {
               if ( $flag == 0 )
               {
                    $flag = 1;
               }
               else
               {
                    $flag = 0;
               }
          }
          if ( $flag == 0 )
          {
               push @filtered, $chr;
          }
     }
     my $count = join('', @filtered) =~ tr/*/*/;
     return $count;
}