use strict;
use warnings;
##
# You are given a positive number $n.
# Write a script to find how many different 
# sequences you can create using Fibonacci 
# numbers where the sum of unique numbers in 
# each sequence are the same as the given number.
##
use Data::PowerSet q/powerset/;

sub fibonacci_below_n{
    my($n, $fibonaccis) = @_;
    $fibonaccis = [1, 1] if !$fibonaccis;
    my $f = $fibonaccis->[@{$fibonaccis} - 2] + $fibonaccis->[@{$fibonaccis} - 1];
    if($f < $n){
        push @{$fibonaccis}, $f;
        fibonacci_below_n($n, $fibonaccis);
    }
    else{
        shift @{$fibonaccis};
        return $fibonaccis;
    }
}

sub fibonacci_sum{
    my($n) = @_;
    my $powerset = powerset(fibonacci_below_n($n));
    my @summands = grep {
        my $fibonaccis = $_;
        my $sum = 0;
        map{
            $sum += $_;
        } @{$fibonaccis};
        $sum == $n;
    } @{$powerset};
    return @summands;
}

MAIN:{
    for my $summands (fibonacci_sum($ARGV[0])){
        print "(" . join(" + ", @{$summands}) . ") = " . $ARGV[0] . "\n";
    }
}


