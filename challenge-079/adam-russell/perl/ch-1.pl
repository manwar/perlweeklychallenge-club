use strict;
use warnings;
##
# You are given a positive number $N.
# Write a script to count the total number of set bits 
# of the binary representations of all numbers 
# from 1 to $N and return $total_count_set_bit % 1000000007.
##
sub count_bits{
    my($n) = @_;
    my $total_count_set_bit = 0;
    for my $x (1 .. $n){
        while($x){
            my $b = $x & 1;
            $total_count_set_bit++ if $b;
            $x = $x >> 1;
        }        
    }
    return $total_count_set_bit;
}


MAIN:{
    my $count = count_bits(4);
    print "$count % 1000000007 = " . $count % 1000000007 . "\n";
    $count = count_bits(3);
    print "$count % 1000000007 = " . $count % 1000000007 . "\n";
}