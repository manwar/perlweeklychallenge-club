use strict;
use warnings;
##
# Write a script to display attractive numbers between 1 and 50.
##
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

MAIN:{
    for my $n (1 .. 50){  
        my @factors = prime_factor($n); 
        print "$n (" . join(", " , @factors) . ")\n" if(prime_factor(scalar @factors) == 1);
    } 
}
