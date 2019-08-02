use strict;
use warnings;
##  
# Write a script that computes the first five perfect numbers. 
# A perfect number is an integer that is the sum of its positive 
# proper divisors (all divisors except itself). 
##
use Thread; 
use Perfect;

use constant THREAD_COUNT => 4;
use constant PERFECT_COUNT => 5;
use constant RANGE_SIZE => 100_000;  

my $p = new Perfect::Perfect();  

sub is_perfect{
    my @numbers = @_;  
    my @perfects = (); 
    foreach my $n (@numbers){
        if($p->isPerfect($n)){
            push @perfects, $n;   
        }  
    }  
    return \@perfects;  
}  

##
# Main  
##
my @threads; 
my $count = 0; 
my $lower = 2; 
my $upper = RANGE_SIZE; 
do{
    for(0..(THREAD_COUNT - 1)){  
        my $t = Thread->new(\&is_perfect, ($lower..$upper));
        push @threads, $t;  
        $lower = $upper + 1;  
        $upper = $lower +  RANGE_SIZE;  
    }  
    foreach my $t (@threads){  
        my $perfects = $t->join();                 
        foreach my $p (@{$perfects}){ 
            print "$p "; 
            $count++;  
        }  
    }   
    @threads = ();   
}while($count < PERFECT_COUNT);
print "\n";  
