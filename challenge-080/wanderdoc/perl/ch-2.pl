#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given rankings of $N candidates. Write a script to find out the total candies needed for all candidates. You are asked to follow the rules below:
a) You must given at least one candy to each candidate.
b) Candidate with higher ranking get more candies than their neighbours.
Example 1:
Input: $N = (1, 2, 2)

Explanation:

Applying rule #a, each candidate will get one candy. So total candies needed so far 3. Now applying rule #b, the first candidate do not get any more candy as its rank is lower than it's neighbours. The second candidate get one more candy as it's ranking is higher than it's neighbour. Finally the third candidate do not get any extra candy as it's ranking is not higher than neighbour. Therefore total candies required is 4.

Output: 4

Example 2:
Input: $N = (1, 4, 3, 2)

Explanation:

Applying rule #a, each candidate will get one candy. So total candies needed so far 4. Now applying rule #b, the first candidate do not get any more candy as its rank is lower than it's neighbours. The second candidate get one more candy as it's ranking is higher than it's neighbour. The third candidate also get one more candy as it's ranking is higher than it's neighbour. Finally the fourth candidate do not get any extra candy as it's ranking is not higher than neighbour. Therefore total candies required is 6.

Output: 6

=cut

use Test::More;


is(count_candies(1, 2, 2), 4,     'Example 1');
is(count_candies(1, 4, 3, 2), 6,  'Example 2');
is(count_candies(2, 0, 2), 5,     'New Example');

done_testing();




sub count_candies
{
     my @arr = @_;

     my $candies = scalar @arr;
     return $candies if $candies == 1;

     $candies++ if ($arr[0] > $arr[1]);

     $candies++ if ($arr[$#arr] > $arr[$#arr - 1]);
     
     for my $i ( 1 .. $#arr - 1 )
     {

          $candies++ if ( $arr[$i] > $arr[$i - 1] or $arr[$i] > $arr[$i + 1] );
     }
     return $candies;

}