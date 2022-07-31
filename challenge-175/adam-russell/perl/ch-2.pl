use strict;
use warnings;
##
# Write a script to generate the first 20 Perfect Totient Numbers.
##
use constant EPSILON => 1e-7;   

sub distinct_prime_factors{
    my $x = shift(@_); 
    my %factors;    
    for(my $y = 2; $y <= $x; $y++){
        next if $x % $y;
        $x /= $y;
        $factors{$y} = undef;
        redo;
    }
    return keys %factors;  
}

sub n_perfect_totients{
    my($n) = @_; 
    my $x = 1;
    my @perfect_totients;
    {
        $x++;
        my $totient = $x;
        my @totients;
        map {$totient *= (1 - (1 / $_))} distinct_prime_factors($x);   
        push @totients, $totient; 
        while(abs($totient - 1) > EPSILON){
            map {$totient *= (1 - (1 / $_))} distinct_prime_factors($totient);   
            push @totients, $totient; 
        }  
        push @perfect_totients, $x if unpack("%32I*", pack("I*", @totients)) == $x;
        redo if @perfect_totients < $n;
    }
    return @perfect_totients;
}

MAIN:{
    print join(", ", n_perfect_totients(20)) . "\n";
}
