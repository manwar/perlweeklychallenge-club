#!usr/bin/perl
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';    # signatures, smartmatch

# Challange 198 - 1 - Max Gap
# You are given a list of integers, @list.
# Write a script to find the total pairs in the sorted list where 2 consecutive elements has the max gap. 
# If the list contains less then 2 elements then return 0.
  

maxGap((2,5,8,1));      # (2,5) and (5,8)
maxGap((2,5,8,1,20));   # (8, 20)
maxGap((3));            # 0

sub maxGap(@list)
{
    @list = sort{$a <=> $b} @list;

    if(@list < 2)
    {
        say "0";
    }
    else
    {
        my $maxGap = 0;
        
        for(my $i = 0; $i < $#list; $i++)
        {
            my $gap = $list[$i+1] - $list[$i];
            $maxGap = $gap   if($gap > $maxGap);
        }
        
        for(my $i = 0; $i < $#list; $i++)
        {
            my $gap = $list[$i+1] - $list[$i];
            
            print("($list[$i], $list[$i+1])") if($gap == $maxGap);
        }
    
    }
    say"";
}