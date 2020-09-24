#You are given a positive number $N.
#Write a script to count the total number of set bits of the binary representations of all numbers from 1 to $N and return $total_count_set_bit % 1000000007.
    
    #Input: $N = 3
    
    #Explanation: First find out the set bit counts of all numbers i.e. 1, 2 and 3.
    
    #    Decimal: 1
    #    Binary: 01
    #    Set Bit Count: 1
    
    #    Decimal: 2
    #    Binary: 10
    #    Set Bit Count: 1
    
    #   Decimal: 3
    #   Binary: 11
    #    Set Bit Count: 2
    
    #    Total set bit count: 1 + 1 + 2 = 4

    #Output: Your script should print `4` as `4 % 1000000007 = 4`.

use strict;
use warnings;
use Data::Dumper;

#variables
my $N = 3;
my $bin;
my @array;
my $count = 0;


convertBinary();
sub convertBinary {

    foreach(my $i = 1; $i <= $N; $i++) {
        $bin = sprintf ("%b", $i);
        @array = ();
        @array = split //, $bin;
        countBit();
    }
    
    print "output: $count\n";
}

sub countBit {
    
    foreach(my $j = 0; $j < @array; $j++) {
        if ($array[$j] == 1) {
            $count++;
        }
    }
}




