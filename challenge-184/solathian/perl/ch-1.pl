#!usr/bin/perl -w

#184 Task 1: Sequence Number

#You are given list of strings in the format aa9999 i.e. first 2 characters can be anything 'a-z' followed by 4 digits '0-9'.

#Write a script to replace the first two characters with sequence starting with '00', '01', '02' etc.

use strict;
use warnings;


# Example calls

#my @list = ( 'ab1234', 'cd5678', 'ef1342');
#Output: ('001234', '015678', '021342')

#my @list = ( 'pq1122', 'rs3334');
#Output: ('001122', '013334')

#sequenceNumber(\@list);




sub sequenceNumber
{
    my $arrayRef = shift;
    my $currentCycle = 0;


    
    foreach my $elem (@$arrayRef)
    {
        my $tempString = $currentCycle;
        
        # extend it to two digits
        if($currentCycle < 10)
        {
            $tempString  = "0".$currentCycle;
        }
        
        # check if the substitution succeeds
        if($elem =~ s/^[a-z]{2}/$tempString/)
        {
            $currentCycle++;
        }
        else
        {
            die"no match in $elem";
        }

    }
    
    print("(",join(",",@$arrayRef),")\n");
    
}

