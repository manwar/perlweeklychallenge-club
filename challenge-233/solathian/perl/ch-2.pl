#!usr/bin/perl
use v5.38;
use Data::Dumper;
use experimental "for_list";

# Challenge 233- 2 - Frequency Sort
# You are given an array of integers.
# Write a script to sort the given array in increasing order based on the frequency of the values. 
# If multiple values have the same frequency then sort them in decreasing order.

freqSort(1,1,2,2,2,3);              # (3,1,1,2,2,2)
freqSort(2,3,1,3,2);                # (1,3,3,2,2)
freqSort(-1,1,-6,4,5,-6,1,4,1);     # (5,-1,4,4,-6,-6,1,1,1)





sub freqSort(@array)
{
    my %hash;
    my @resultArray;

    # creating occurrence hash
    foreach my $elem ( @array)
    {
        my $count = scalar grep{ $elem eq $_ } @array;
        
        $hash{$elem} += $count;                         # will get the occurrence^2 but it is fine!
    }


    # do some post process, since we collected squares, also we need to sort by another parameter if needed
    foreach my($key, $value) ( %hash)
    {       
        $hash{$key} = {occ => sqrt($value), order => $value * $key};

    }
    
    # sort via the occurence or sort via reverse order
    foreach my $key ( sort { $hash{$a}{occ} <=> $hash{$b}{occ} || $hash{$b}{order} <=> $hash{$a}{order}} keys %hash)
    {
        for(1..$hash{$key}{occ})
        {
            push(@resultArray, $key);
        }
    }

    # create output
    say join ',', @resultArray;

}