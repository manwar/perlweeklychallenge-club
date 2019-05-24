use strict;
use warnings;
##  
# Write a script that computes the first five perfect numbers. 
# A perfect number is an integer that is the sum of its positive 
# proper divisors (all divisors except itself). 
##
use constant PERFECT_COUNT => 5;

sub factor{
    my($n) = @_;
    my @factors = (1);
    foreach my $j (2..sqrt($n)){
        push @factors, $j if $n % $j == 0;
        push @factors, ($n / $j) if $n % $j == 0 && $j ** 2 != $n;
    }    
    return @factors;  
}

my $i = 2; 
my $count = 0; 
do{
    my @factors = factor($i);
    my $sum = unpack("%32I*", pack("I*", @factors));  
    if($sum == $i){
        print "$i ";   
        $count++;   
    }    
    $i++;   
}while($count < PERFECT_COUNT);
print "\n";   
