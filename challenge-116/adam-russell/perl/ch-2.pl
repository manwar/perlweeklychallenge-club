use strict;
use warnings;
##
# You are given a number $N >= 10.
# Write a script to find out if the given number $N is such 
# that sum of squares of all digits is a perfect square. 
# Print 1 if it is otherwise 0.
##
use POSIX; 

sub sum_squares{
    my($n) = @_;
    my @digits = split(//, $n);
    my $sum = 0;
    map { $sum += ($_ ** 2) } @digits; 
    return (ceil(sqrt($sum)) == floor(sqrt($sum)));   
}

MAIN:{
    my($N);
    $N = 34;
    if(sum_squares($N)){
        print "1\n";  
    }  
    else{
        print "0\n";  
    }  
    $N = 50;
    if(sum_squares($N)){
        print "1\n";  
    }  
    else{
        print "0\n";  
    }  
    $N = 52;
    if(sum_squares($N)){
        print "1\n";  
    }  
    else{
        print "0\n";  
    }  
}
