use strict;
use warnings;
##
# Write a script to print all possible series 
# of 3 positive numbers, where in each series 
# at least one of the number is even and sum 
# of the three numbers is always 12.
##
use boolean; 
use Math::Combinatorics;

sub has_even{
    my @numbers = @_;
    my @evens = grep { $_ % 2 == 0 } @numbers;
    if(@evens){
        return true; 
    }  
    return false; 
}

sub sums_12{
    my @numbers = @_;
    my $sum = unpack("%32I*", pack("I*", @numbers));  
    if($sum == 12){
        return true;
    }
    return false; 
}

MAIN:{
    my $combinations = new Math::Combinatorics(count => 3,
                                               data  => [-10 .. 10]  
    );
    my @combination = $combinations->next_combination();
    do{
        if(has_even(@combination) and sums_12(@combination)){
            print "@combination\n"; 
        } 
        @combination = $combinations->next_combination();
    } while(@combination);
}  
