use strict;
use warnings;

#3 Sum

#Given an array @Lof integers. 
#Write a script to find all unique triplets such that a + b + c is same as the given target T. 
#Also make sure a <= b <= c.

my $target = 0;
my  @L = sort(-25,  -7, -3, 2, 4, -10,8, 10);

foreach my $a (0..$#L){
    foreach my $b ($a+1..$#L){
        foreach my $c ($b+1..$#L){            
            if ( ($L[$a] + $L[$b] + $L[$c]) == $target){
                print $L[$a]."  + ".$L[$b]." + ".$L[$c]." = $target.\n";
            }
        }
    }
}

