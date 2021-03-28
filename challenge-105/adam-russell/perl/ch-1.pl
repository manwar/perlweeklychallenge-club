use strict;
use warnings;
##
# You are given positive numbers $N and $k.
# Write a script to find out the $Nth root of $k. 
##
sub nth_root{
    my($n, $k) = @_;
    my $x_i = int(rand(10) + 1); 
    my $r;
    for my $i (0 .. 100){
        $x_i = (1 / $n) * (($n - 1) * $x_i + ($k / $x_i ** ($n - 1)));  
    } 
    return $x_i;  
}

MAIN:{
    my($N, $k);
    $N = 5;
    $k = 248832;
    print nth_root($N, $k) . "\n";
    $N = 5;
    $k = 34;
    print sprintf("%0.2f", nth_root($N, $k)) . "\n";
}
