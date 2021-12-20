use strict;
use warnings;
##
# You are given a positive number, $n. Write a script to 
# find out if the given number is Stealthy Number.   
##
use boolean; 

sub factor{
    my($n) = @_;
    my @factors = ();
    for  my $j (2 .. sqrt($n)){
        push @factors, [$j, $n / $j] if $n % $j == 0;
    }
    return @factors;  
}

sub stealthy{
    my($n) = @_;
    my @factors = factor($n);
    for(my $i = 0; $i < @factors; $i++){
        for(my $j = 0; $j < @factors; $j++){
            unless($i == $j){
                my($s, $t) = @{$factors[$i]}; 
                my($u, $v) = @{$factors[$j]}; 
                return true if $s + $t == $u + $v + 1; 
            }  
        }  
    }  
    return false; 
}

MAIN:{
    print stealthy(12) . "\n";
    print stealthy(36) . "\n";
    print stealthy(6)  . "\n";
}
