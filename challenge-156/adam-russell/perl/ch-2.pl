use strict;
use warnings;
##
# You are given number, $n > 0. Write a script to find out if 
# the given number is a Weird Number.
##
use boolean;
use Data::PowerSet q/powerset/;

sub factor{
    my($n) = @_;
    my @factors = (1);
    foreach  my $j (2 .. sqrt($n)){
        push @factors, $j if $n % $j == 0;
        push @factors, ($n / $j) if $n % $j == 0 && $j ** 2 != $n;
    }
    return @factors;  
}

sub is_weird{
    my($x) = @_;
    my @factors = factor($x); 
    my $sum = unpack("%32I*", pack("I*",  @factors));
    for my $subset (@{powerset(@factors)}){
        return false if unpack("%32I*", pack("I*",  @{$subset})) == $x;
    }  
    return boolean($sum > $x);
}

MAIN:{
    print is_weird(12) . "\n";
    print is_weird(70) . "\n";
}