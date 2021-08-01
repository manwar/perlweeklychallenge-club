use strict;
use warnings;
##
# You are given an integer $n >= 1.
# Write a script to find the $nth Ugly Number.   
##
use boolean;

sub prime_factor{
    my $x = shift(@_); 
    my @factors;    
    for (my $y = 2; $y <= $x; $y++){
        next if $x % $y;
        $x /= $y;
        push @factors, $y;
        redo;
    }
    return @factors;  
}

sub is_ugly{
    my($x) = @_; 
    for my $factor (prime_factor($x)){
        return false if $factor != 2 && $factor != 3 && $factor !=5; 
    }
    return true; 
}

sub nth_ugly{
    my($n) = @_;  
    return 1 if $n == 1; 
    my $ugly_count = 1; 
    my $i = 1;  
    do{
        $i++;
        $ugly_count++ if is_ugly($i);   
    }while($ugly_count != $n);
    return $i;    
} 

MAIN:{
    my($N);
    $N = 7; 
    print nth_ugly($N) . "\n"; 
    $N = 10; 
    print nth_ugly($N) . "\n"; 
}   
