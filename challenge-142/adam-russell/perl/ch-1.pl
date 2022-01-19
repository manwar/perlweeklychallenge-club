use strict;
use warnings;
##
#  You are given positive integers, $m and $n. Write a script to
#  find total count of divisors of $m having last digit $n  
##
sub factor{
    my($n) = @_;
    my @factors = (1);
    foreach  my $j (2 .. sqrt($n)){
        push @factors, $j if $n % $j == 0;
        push @factors, ($n / $j) if $n % $j == 0 && $j ** 2 != $n;
    }
    return @factors;  
}

sub divisors_last_digit{
    my($m, $n) = @_;
    my @divisors;   
    my @factors = factor($m);
    {
        my $factor = pop @factors;
        push @divisors, $factor if $n == substr($factor, -1);    
        redo  if @factors;  
    }    
    return sort {$a <=> $b} @divisors;   
}

MAIN:{
    my($m, $n); 
    my @divisors;
    ($m, $n) = (24, 2); 
    @divisors = divisors_last_digit($m, $n);
    print "($m, $n): " . @divisors . " --> " . join(", ", @divisors) . "\n";  
    ($m, $n) = (75, 5); 
    @divisors = divisors_last_digit($m, $n);
    print "($m, $n): " . @divisors . " --> " . join(", ", @divisors) . "\n";  
    ($m, $n) = (30, 5); 
    @divisors = divisors_last_digit(30, 5);
    print "($m, $n): " . @divisors . " --> " . join(", ", @divisors) . "\n";  
}
