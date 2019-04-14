use strict;
use warnings;
##
# Create a script to generate 5-smooth numbers, whose prime divisors are less or equal to 5. 
# They are also called Hamming/Regular/Ugly numbers.  
##
use boolean; 

sub is_divisible{
    my($divisor) = @_;  
    return sub{
        my($x) = @_;
        if($x % $divisor == 0){
            return true;  
        }   
        return false;  
    }   
}  

my $is_divisible_by_2 = is_divisible(2);  
my $is_divisible_by_3 = is_divisible(3);  
my $is_divisible_by_5 = is_divisible(5);  

sub is_hamming{
    my($x) = @_;
    if($x == 1){
        return true;  
    }  
    if($is_divisible_by_2->($x)){
        return is_hamming($x/2);  
    }    
    if($is_divisible_by_3->($x)){
        return is_hamming($x/3);  
    }    
    if($is_divisible_by_5->($x)){
        return is_hamming($x/5);  
    }    
    return false;  
}  

sub generate_hamming_sequence{  
        my($x) = @_;  
	if($x == 1){
            return true;  
        }  
	generate_hamming_sequence($x - 1);  
	if(is_hamming($x)){
            print("$x ");  
        }  
} 

generate_hamming_sequence(64);   
