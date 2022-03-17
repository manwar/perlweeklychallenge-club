use strict;
use warnings;
##
# Write a script to find the period of the third Pisano Period.
##
use constant N => 1_000_000_000; 

sub fibonacci_below_n{
    my($n, $fibonaccis) = @_;
    $fibonaccis = [1, 1] if !$fibonaccis;
    my $f = $fibonaccis->[@{$fibonaccis} - 2] + $fibonaccis->[@{$fibonaccis} - 1];
    if($f < $n){
        push @{$fibonaccis}, $f;
        fibonacci_below_n($n, $fibonaccis);
    }
    else{
        return $fibonaccis;
    }
}

sub multiplicative_order{
    my($a, $n) = @_;
    my $k = 1;
    my $result = 1;
    while($k < $n){
        $result = ($result * $a) % $n;
        return $k if $result == 1;
        $k++;
    }
    return -1 ;
}

sub fibonacci_period_mod_n{
    my($n) = @_;
    my $fibonaccis = fibonacci_below_n(N);
    my $k = 1;
    for my $f (@{$fibonaccis}){
        if($f % $n == 0){
            return $k * multiplicative_order($fibonaccis->[$k+1], $n);
        }
        $k++;
    }
    return -1;
}

MAIN:{
    print fibonacci_period_mod_n(3) . "\n";
}