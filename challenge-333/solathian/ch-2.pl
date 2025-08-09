#!usr/bin/perl
use v5.40;

# Challenge 333 - 2 - Duplicate Zeros
# Each zero is duplicated.
# Elements beyond the original length (like 5 and last 0) are discarded.


say dz(1, 0, 2, 3, 0, 4, 5, 0); #  (1, 0, 0, 2, 3, 0, 0, 4)
say dz(1, 2, 3);                #  (1, 2, 3)
say dz(1, 2, 3, 0);             #  (1, 2, 3, 0)
say dz(0, 0, 1, 2);             #  (0, 0, 0, 0)
say dz(1, 2, 0, 3, 4);          #  (1, 2, 0, 0, 3)

sub dz(@list)
{
    substr( join('', @list) =~ s/0/00/gr, 0, scalar @list)
}