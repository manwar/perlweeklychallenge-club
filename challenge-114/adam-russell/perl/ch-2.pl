use strict;
use warnings;
##
# You are given a positive integer $N.
# Write a script to find the next higher integer 
# having the same number of 1 bits in binary representation as $N.
##
sub count_bits{
    my($n) = @_;
    my $total_count_set_bit = 0;
    while($n){
        my $b = $n & 1;
        $total_count_set_bit++ if $b;
        $n = $n >> 1;
    }        
    return $total_count_set_bit;
}

sub next_same_bits{
    my($n) = @_; 
    my $number_bits = count_bits($n);  
    {
        my $next = $n + 1;  
        return $next if count_bits($next) == $number_bits;
        $n = $next;
        redo;   
    }       
}    

MAIN:{
    my($N);
    $N = 3;
    print next_same_bits($N) . "\n";   
    $N = 12;
    print next_same_bits($N) . "\n";   
}   
