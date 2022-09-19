use strict;
use warnings;
##
# You are given an integer greater than 1. Write a script to find the home prime of the 
# given number.
##
use bigint;
use Math::Primality qw/is_prime/;

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

sub home_prime{
    my($n) = @_;
    return $n if is_prime($n);
    my $s = $n;
    {
        $s = join("", prime_factor($s));
        redo if !is_prime($s);
    }
    return $s;
}

MAIN:{
    print home_prime(10) . "\n";
    print home_prime(16) . "\n";
    print home_prime(48) . "\n";
}