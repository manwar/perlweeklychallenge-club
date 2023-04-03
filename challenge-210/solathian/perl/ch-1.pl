#!usr/bin/perl
use v5.36;

# Challenge 210 - 1 - Kill and Win

# You are given a list of integers.
# Write a script to get the maximum points. You are allowed to take out (kill) any integer and remove from the list. 
# However if you do that then all integers exactly one-less or one-more would also be removed. 
# Find out the total of integers removed.

killAndWin(2, 3, 1);
# First we delete 2 and that would also delete 1 and 3. So the maximum points we get is 6.
killAndWin(1, 1, 2, 2, 2, 3);
# First we delete 2 and that would also delete both the 1's and the 3. Now we have (2, 2).
# Then we delete another 2 and followed by the third deletion of 2. So the maximum points we get is 11.


###
# according to the current rules we do not have to think since the one-less and one-more elements are also counted
# and we can take any number of steps
# so the sum of the elements will be the max with the current rules
# it would be much more challenging if during the one-less and one-more take away would not be counted for the total
# sadly did not have time to implement that :(
###

sub killAndWin
{
    my $sum;
    foreach my $var (@_)
    {
        $sum += $var;
    }
    
    say $sum;
}
