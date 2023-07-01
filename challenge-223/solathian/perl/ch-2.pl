#!usr/bin/perl
use v5.36;
use List::Util qw(max);
use Algorithm::Combinatorics qw(permutations);
use experimental 'declared_refs';

# Challenge 223 - 2 - Box Coins
# You are given an array representing box coins, @box.
# Write a script to collect the maximum coins until you took out all boxes. 
# If we pick box[i] then we collect the coins $box[i-1] * $box[i] * $box[i+1]. 
# If $box[i+1] or $box[i-1] is out of bound then treat it as 1 coin.

boxCoins(1, 5);             # 10
boxCoins(3, 1, 5, 8);       # according to the example 167 but there is better solution 189

=Note

5,3,1,8                 target 2        24  = 3 * 1 * 8
5,3,8                   target 1        120 = 5 * 3 * 8
5,8                     target 1        40  = 5 * 8 * 1
5                       target 0        5   = 1 * 5 * 1

120 + 24 + 40 + 5
Overall:189
=cut
 

sub boxCoins(@inputArray)
{
    
    my @theSums;       # https://www.youtube.com/watch?v=qO-mSLxih-c

    foreach my $arrayRef (permutations \@inputArray)    # go with the brute force approach I guess
    {
        my $sum;
        my \@boxArray = $arrayRef;
    
        while(@boxArray > 0)
        {
            # always pick an element in the middle
            my $targetIndex = int(@boxArray/2);

            my $prev    =  (0 <= ($targetIndex-1) < @boxArray )   ? $boxArray[$targetIndex-1] : 1;
            my $current =                                           $boxArray[$targetIndex];
            my $next    =  (0 <= ($targetIndex+1) < @boxArray )   ? $boxArray[$targetIndex+1] : 1;
            
            $sum += $prev * $current * $next;
            
            # remove the element in the middle
            splice @boxArray, $targetIndex, 1;       
        }
        push(@theSums, $sum);
    }
    say max(@theSums);
}