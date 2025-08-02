#!usr/bin/perl
use v5.38;

# Challenge 250 - 2 - Alphanumeric String Value
# You are given an array of alphanumeric strings.
# Write a script to return the maximum value of alphanumeric string in the given array.
# The value of alphanumeric string can be defined as

# a) The numeric representation of the string in base 10 if it is made up of digits only.
# b) otherwise the length of the string


asv("perl", "2", "000", "python", "r4ku");
asv("001", "1", "000", "0007");


sub asv(@list)
{
    my $max = 0;
    
    foreach my $elem (@list)
    {
        # if it only has numbers
        if($elem =~ m"^\d+$")
        {
            $max = eval $elem     if( $elem > $max );
        }
        else
        {
           $max = length $elem     if( length $elem > $max );
        }
    }
    
    say $max;
}