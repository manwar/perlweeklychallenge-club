#!usr/bin/perl -w

# Created for perl weekly challenge - 183 - 1

# You are given list of arrayrefs.
# Write a script to remove the duplicate arrayrefs from the given list.

use strict;
use warnings;
use feature 'say';

no warnings 'experimental::smartmatch';

use constant
{
    FALSE => 0,
    TRUE  => 1,
};


#example calls
# my @list = ([1,2], [3,4], [5,6], [1,2]);          # ([1,2], [3,4], [5,6])
# my @list = ([1,2], [3,4], [5,6], [1,2], [1,2,3], [6,5]);
# my @list = ([9,1], [3,7], [2,5], [2,5]);          # ([9, 1], [3,7], [2,5])

# findDuplicates(\@list);

sub findDuplicates
{
    my $arrayRef = shift;   
    my @arrayStorage;

    print "("; # print the starting parenthesis
   
    foreach my $subArray (@$arrayRef)
    {
        
        # check that if current element matches any of the previous ones
        my $duplicateFlag = FALSE;
        foreach my $storedElem (@arrayStorage)
        {
            if($storedElem ~~ $subArray)    # using smartmatch
            {
                $duplicateFlag = TRUE;
                last;
            }

        }

        # if it is a duplicated element
        next if($duplicateFlag == TRUE);
        
        # start printing out the collected elements
        print(",") if( 0 < @arrayStorage );
        print("[".join(',',@$subArray)."]");
        
        # store the element
        push(@arrayStorage, $subArray);
        
        
    }
  
    print(")"); # print the closing parenthesis

    return \@arrayStorage;
}

