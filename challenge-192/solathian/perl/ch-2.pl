#!usr/bin/perl
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';

# Challange 192 - 2 - Equal Distribution

# You are given a list of integers greater than or equal to zero, @list.
# Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.
# Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]


# 1) You can only move a value of '1' per move
# 2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

use constant
{
    FALSE => 0,
    TRUE => 1,
};

# my @test0 = (1, 0, 5);
# my @test1 = (0, 2, 0);
# my @test2 = (0, 3, 0);

# maskCode(@test0);
# maskCode(@test1);
# maskCode(@test2);

sub isItDone($target, @list)
{
    foreach my $elem (@list)
    {
        return FALSE if($elem != $target);
        
    }
    
    return TRUE;
}


sub maskCode(@list)
{
    my $sum;
    map($sum += $_, @list);
    
    my $target = $sum/@list;
    
    # check if it is even
    if(int($target) == $target)
    {
        my $steps;
        my $i = 0;
        while( isItDone($target, @list) == FALSE)
        {
            if(($i + 1) > $#list)
            {
                $i = 0;
                @list = reverse @list;  # reverse the list for the next round
            }
            
            if(($list[$i] > $target))   # move items until we reach target
            {
                if($list[$i+1] != $target)  # try to place to the right
                {
                    $steps++;
                    $list[$i]--;
                    $list[$i+1]++;
                }
                elsif(($list[$i-1] != $target) && (($i-1) != 0))
                {
                    $steps++;
                    $list[$i]--;
                    $list[$i-1]++;
                }
                
                else
                {
                    $i++;
                }

                
            }
            else
            {
                $i++;
            }

        }
        say $steps;
    }
    
    # it is odd, it cannot be done
    else
    {
        say -1;
        return -1;
    }

}