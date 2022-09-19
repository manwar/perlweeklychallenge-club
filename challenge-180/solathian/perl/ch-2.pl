#!usr/bin/perl -w

# Created for perl weekly challenge - 180 - 2

# Write a script to trim the given list where element is less than or equal to the given integer.
# Must note that the given example is wrong.

use strict;
use warnings;


# sample calls

# my @sampleArray = (9,0,6,2,3,8,5);
# trimList(\@sampleArray, 4);

# my @sampleArray = (1,4,2,3,5);
# trimList(\@sampleArray, 3);


# my @sampleArray = (9,0,6,2,3,8,5);
# trimList_noPrint(\@sampleArray, 4);

# my @sampleArray = (1,4,2,3,5);
# trimList_noPrint(\@sampleArray, 3);


sub trimList
{
    my ($arrayRef, $threshold)  = @_;

    my @output;
    
    print( 'Output: (' );
    
    for(my $i = 0, my $length = @$arrayRef; $i < $length; $i++)
    {
        my $elem = $arrayRef->[$i];
        
        # check if the element is greater than the threshold
        if($elem >  $threshold)
        {         
            push(@output, $elem);
            
            print(",")      if(@output != 1);   #do not print a ',' before the first item
            print($elem);
        }
    }
    print( ')' );

    
    return \@output;
}


# without print

sub trimList_noPrint
{
    my ($arrayRef, $threshold)  = @_;

    my @output;
    
    foreach my $elem (@$arrayRef)
    {
        if($elem >  $threshold)
        {         
            push(@output, $elem);
        }
    }   

    return \@output;
}