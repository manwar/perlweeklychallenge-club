#!/usr/bin/env perl6
#
# Compose and print identity matrix
#
# Notes:
# - "is default" trait not implemented for shaped arrays
# - Partially dimensioned views of shaped arrays not yet implemented
# - Could use Math::Matrix

sub MAIN (Int $dim)
{
    my @md[$dim;$dim];

    for 0..$dim-1 -> $i {
        for 0..$dim-1 -> $j {
            @md[$i;$j]= $i==$j ?? 1 !! 0;
            printf "%3i", @md[$i;$j];
        }
    printf "\n";
    }
}
