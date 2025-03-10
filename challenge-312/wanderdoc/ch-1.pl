#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a typewriter with lowercase english letters a to z arranged in a circle.

Task 1

Typing a character takes 1 sec. You can move pointer one character clockwise or anti-clockwise.

The pointer initially points at a.

Write a script to return minimum time takes to print the given string.
Example 1

Input: $str = "abc"
Output: 5

The pointer is at 'a' initially.
1 sec - type the letter 'a'
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer clockwise to 'c'
1 sec - type the letter 'c'

Example 2

Input: $str = "bza"
Output: 7

The pointer is at 'a' initially.
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer anti-clockwise to 'a'
1 sec - move pointer anti-clockwise to 'z'
1 sec - type the letter 'z'
1 sec - move pointer clockwise to 'a'
1 sec - type the letter 'a'

Example 3

Input: $str = "zjpc"
Output: 34
=cut

use List::Util qw(min);
use Test2::V0 -no_srand => 1;

is(min_time('abc'), 5, 'Example 1');
is(min_time('bza'), 7, 'Example 2');
is(min_time('zjpc'), 34, 'Example 3');
done_testing();

sub min_time
{
     my $str = $_[0];
     my %letters = map { chr($_) => $_ - ord('a') } 
                         ord('a') .. ord('z');
     my $start_num = $letters{substr($str, 0     , 1)};
     my $output = min($start_num, 26 - $start_num);
     $output++; # type.
     for my $idx ( 1 .. length($str) - 1 )
     {
          my $num_1 = $letters{substr($str, $idx - 1, 1)};
          my $num_2 = $letters{substr($str, $idx    , 1)};
          my $diff = min(abs($num_1 - $num_2),
                    $num_1 + (26 - $num_2), 
                    $num_2 + (26 - $num_1));
          $output += $diff;
          $output++; # type.
     }
     return $output;
}
