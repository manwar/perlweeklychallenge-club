#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of scores by a team.
Write a script to find the total score of the given team. The score can be any integer, +, C or D. The + adds the sum of previous two scores. The score C invalidates the previous score. The score D will double the previous score.

Example 1

Input: @scores = ("5","2","C","D","+")
Output: 30

Round 1: 5
Round 2: 5 + 2
Round 3: 5 (invalidate the previous score 2)
Round 4: 5 + 10 (double the previous score 5)
Round 5: 5 + 10 + 15 (sum of previous two scores)

Total Scores: 30


Example 2

Input: @scores = ("5","-2","4","C","D","9","+","+")
Output: 27

Round 1: 5
Round 2: 5 + (-2)
Round 3: 5 + (-2) + 4
Round 4: 5 + (-2) (invalidate the previous score 4)
Round 5: 5 + (-2) + (-4) (double the previous score -2)
Round 6: 5 + (-2) + (-4) + 9
Round 7: 5 + (-2) + (-4) + 9 + 5 (sum of previous two scores)
Round 8: 5 + (-2) + (-4) + 9 + 5 + 14 (sum of previous two scores)

Total Scores: 27


Example 3

Input: @scores = ("7","D","D","C","+","3")
Output: 45

Round 1: 7
Round 2: 7 + 14 (double the previous score 7)
Round 3: 7 + 14 + 28 (double the previous score 14)
Round 4: 7 + 14 (invalidate the previous score 28)
Round 5: 7 + 14 + 21 (sum of previous two scores)
Round 6: 7 + 14 + 21 + 3

Total Scores: 45


Example 4

Input: @scores = ("-5","-10","+","D","C","+")
Output: -55

Round 1: (-5)
Round 2: (-5) + (-10)
Round 3: (-5) + (-10) + (-15) (sum of previous two scores)
Round 4: (-5) + (-10) + (-15) + (-30) (double the previous score -15)
Round 5: (-5) + (-10) + (-15) (invalidate the previous score -30)
Round 6: (-5) + (-10) + (-15) + (-25) (sum of previous two scores)

Total Scores: -55


Example 5

Input: @scores = ("3","6","+","D","C","8","+","D","-2","C","+")
Output: 128

Round  1: 3
Round  2: 3 + 6
Round  3: 3 + 6 + 9 (sum of previous two scores)
Round  4: 3 + 6 + 9 + 18 (double the previous score 9)
Round  5: 3 + 6 + 9 (invalidate the previous score 18)
Round  6: 3 + 6 + 9 + 8
Round  7: 3 + 6 + 9 + 8 + 17 (sum of previous two scores)
Round  8: 3 + 6 + 9 + 8 + 17 + 34 (double the previous score 17)
Round  9: 3 + 6 + 9 + 8 + 17 + 34 + (-2)
Round 10: 3 + 6 + 9 + 8 + 17 + 34 (invalidate the previous score -2)
Round 11: 3 + 6 + 9 + 8 + 17 + 34 + 51 (sum of previous two scores)

Total Scores: 128
=cut






use List::Util qw(sum);

use Test2::V0 -no_srand => 1;
is(final_score("5","2","C","D","+"), 30, 'Example 1');
is(final_score("5","-2","4","C","D","9","+","+"), 27, 'Example 2');
is(final_score("7","D","D","C","+","3"), 45, 'Example 3');
is(final_score("-5","-10","+","D","C","+"), -55, 'Example 4');
is(final_score("3","6","+","D","C","8","+","D","-2","C","+"), 128, 'Example 5');
done_testing();

sub final_score
{
     my @arr = @_;
     my @cache;
     for my $elm ( @arr )
     {
          if ( $elm =~ /\-?\d/ )
          {
               push @cache, $elm;
          }
          elsif ( $elm eq '+' )
          {
               if ( scalar @cache > 1 )
               {
                    push @cache, sum (@cache[$#cache-1, $#cache]);
               }
               elsif ( scalar @cache == 1 )
               {
                    # not in the challenge, just a guess:
                    push @cache, $cache[0];
               }
          }
          elsif ( $elm eq 'C' )
          {
               pop @cache;
          }
          elsif ( $elm eq 'D' )
          {
               push @cache, sum (@cache[$#cache, $#cache]);
          }
     }
     return sum(@cache);
}
