#!usr/bin/perl
use v5.36;

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);
use builtin qw( true false);
no warnings 'experimental';

# Challenge 211 - 2 - Split Same Average
# You are given an array of integers.
# Write a script to find out if the given can be split into two separate arrays whose average are the same.
# (1, 2, 3, 4, 5, 6, 7, 8)



ssa(1, 2, 3, 4, 5, 6, 7, 8);
# ssa(1, 2, 3, 4, 4, 6, 7, 8);
# We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
# The average of the two arrays are the same i.e. 4.5.
# Output: true

ssa(1, 3);

# Output: false

sub getLeftOut($originalArray, $firstArray)
{
    my @secondArray;
    
    foreach my $elem (@$originalArray)
    {
        next if($elem ~~ @$firstArray);
        
        push(@secondArray, $elem);
        
        # yes, currently it goes haywire if the array is not unique
    }
    
    return \@secondArray;
}

sub splitArray($arrayRef, $firstSize)
{
    my @resultArray;
    
    foreach my $firstPart ( combinations($arrayRef, $firstSize))
    {
        my $secondArray = getLeftOut($arrayRef, $firstPart);

        push(@resultArray, [$firstPart, $secondArray])
    }

    return \@resultArray;
}

sub avg($list) 
{
    return sum(@$list) / @$list;
}



sub ssa(@list)
{
   
    say "Array: @list";
    
    my $currentSize = 1;
    my $returnFlag  = false;
    
    OUTER:
    while($currentSize < (@list - 1))
    {
        my $splitArrays = splitArray(\@list, $currentSize);
        
        foreach my $splitArray (@$splitArrays)
        {
            my $first   = $splitArray->[0];
            my $second  = $splitArray->[1];
            
            if(avg($first) == avg($second))
            {
                
                say "Found an array:";
                say "Average is:" . avg($first);
                say '(' . join(',', @$first) . '),('. join(',', @$second) . ')';
                say "";
                $returnFlag = true;
                last OUTER;
            }
        }

        $currentSize++;
    }
    
    if(!$returnFlag){say "Did not found such array"}
}