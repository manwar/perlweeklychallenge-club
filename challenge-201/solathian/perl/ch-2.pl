#!usr/bin/perl
use v5.36;

use Storable qw(dclone);

# Challange 201 - 2 - Penny Piles

# You are given an integer, $n > 0.

# Write a script to determine the number of ways of putting $n 
# pennies in a row of piles of ascending heights from left to right.






# pennyPiles(5);
# pennyPiles(7);

sub pennyPiles($n)
{
    my @pennyRows;
    
    
    # create initial array of 1s
    my @arr = (1) x $n;
    
    push(@pennyRows, dclone(\@arr));
    
    
    
    MAIN:while()
    {
        
        
        # try to merge 1s from the right 1 1 1 1 1 -> 1 1 1 2, or 1 1 3 -> 2 3
        for(my $i = $#arr; $i > 0; $i--)
        {
            if(($arr[$i] == 1) && ($arr[$i-1] == 1))
            {
                splice(@arr, $i, 1);
                $arr[$i-1] = 2;
                push(@pennyRows, dclone(\@arr));
                next MAIN;
            }
        }
        
        # try to move 1s from the left to right 2 3 -> 1 4
        for(my $i = 0; $i < $#arr; $i++)
        {
            if($arr[$i] > 1 )
            {
                $arr[$i]--;
                $arr[$#arr]++;
                push(@pennyRows, dclone(\@arr));
                next MAIN;
            }
        }
        
        
        # last step  1 4 -> 5
        if(@arr == 2)
        {
            splice(@arr, 0, 1);
            $arr[0]++;
            push(@pennyRows, dclone(\@arr));
        }

        last if(@arr == 1)
        
    }

    say "\$n is $n, There are ". scalar(@pennyRows). " ways of stacking $n pennies in ascending piles:";
    foreach my $row (@pennyRows)
    {
        say @$row;
    }
 
    
}