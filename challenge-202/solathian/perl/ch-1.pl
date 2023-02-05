#!usr/bin/perl
use v5.36;

# Challange 202 - 1 - Consecutive Odds
# You are given an array of integers.
# Write a script to print 1 if there are THREE consecutive odds in the given array otherwise print 0.

consOdds(2,3,5,7);  #1
consOdds(1,2,3,4);  #0
consOdds(2,6,3,5);  #0
consOdds(1,5,3,6);  #1


sub consOdds(@array)
{
    my $count = 0;
    foreach my $elem (@array)
    {
        if(($elem % 2) == 1)
        {
            $count++;
            last if($count == 3);
            
        }
        else
        {
            $count = 0;
        }   
    }

    
    if($count == 3) {say 1}
    else            {say 0}
}