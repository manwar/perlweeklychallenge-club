#!usr/bin/perl
use v5.36;

use builtin 'indexed';
no warnings builtin::indexed;

# Challange 200 - 1 - Arithmetic Slices
# You are given an array of integers.

# Write a script to find out all Arithmetic Slices for the given array of integers.

# An integer array is called arithmetic if it has at least 3 elements and 
# the differences between any three consecutive elements are the same.

use Data::Dumper;

arithmSlice(1,2,3,4);         # Output: (1,2,3), (2,3,4), (1,2,3,4)
arithmSlice(1,2,3,4, 7);
arithmSlice(2);               # Output ()
# arithmSlice(2,3);
arithmSlice(1,2,3,4,5);
# arithmSlice(2, 4, 6, 8);
# arithmSlice(2);



sub arithmSlice(@array)
{
    my @arraySlices;
    my @resultArrays;

    if(@array < 3)
    {
        say "()";
        return;
    }
    
    # create partitions
    for(my $chain = 2; $chain < @array; $chain++)
    {
        my $i = 0;
        
        while( ($i + $chain) < @array)
        {
            my @slice = @array[$i .. ($i + $chain)];
            push (@arraySlices, \@slice);
            
            $i++;
        }
        
    }
    
    # check the slices
    OUTER:  foreach my $arrayRef (@arraySlices)
    {
        my $diff = $arrayRef->[1] - $arrayRef->[0];
        my $last;
        
        foreach my ($i, $value) (indexed @$arrayRef)
        {
            if( not defined $last)
            {
                $last = $value;
                next;
            }
            
            if(($value - $last) != $diff)
            {
                next OUTER;
            }
            
            $last = $value;
        }
        
        push(@resultArrays, $arrayRef)
    }
    
    # create output
    map{ print "(", join(",", @$_ ), ")," } @resultArrays;
    say "";

}