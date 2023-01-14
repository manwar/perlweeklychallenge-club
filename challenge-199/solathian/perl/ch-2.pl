#!usr/bin/perl

use v5.36;
use builtin 'indexed';
no warnings builtin::indexed;

# Challange 199 - 2 - Good Triplets
# You are given an array of integers, @array and three integers $x,$y,$z.
# Write a script to find out total Good Triplets in the given array.
# A triplet array[i], array[j], array[k] is good if it satisfies the following conditions:

goodTriplets([3,0,1,1,9,7], 7, 2, 3);   # 4
goodTriplets([1,1,2,2,3],   0, 0, 1);   # 0

sub goodTriplets($array, $x, $y, $z )
{
    my $count = 0;
    
    foreach my ($i, $iVal) (indexed @$array)
    {
        foreach my ($j, $jVal) (indexed @$array)
        {
            foreach my ($k, $kVal) (indexed @$array)
            {
                next if( not ( $i < $j < $k));                  # a) 0 <= i < j < k <= n (size of given array)
                next if( not (abs( $iVal - $jVal) <= $x));      # b) abs(array[i] - array[j]) <= x
                next if( not (abs( $jVal - $kVal) <= $y));      # c) abs(array[j] - array[k]) <= y
                next if( not (abs( $iVal - $kVal) <= $y));      # d) abs(array[i] - array[k]) <= z
                
                $count++;
            }
        }
    }
 
    say    $count;
    return $count
}