use strict;
use warnings;
use Data::Dumper;

#Diff-K

#You are given an array @N of positive integers (sorted) and another non negative integer k.

#Write a script to find if there exists 2 indices i and j such that A[i] - A[j] = k and i != j.

#It should print the pairs of indices, if any such pairs exist.

#Example:

#    @N = (2, 7, 9)
#    $k = 2

#Output : 2,1


my @N = (2, 7, 9);
my $k = 2;


foreach my $i (reverse(1..$#N)){
    foreach my $j (reverse(0..$i-1)){
        my $difference = $N[$i] - $N[$j];
        if ($difference  == $k){
            print "Output : $i,$j\n";
        }
    }
}