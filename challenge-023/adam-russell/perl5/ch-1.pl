use strict;
use warnings;
##
# Create a script that prints nth order forward difference series.
##
use Data::Dump q/pp/; 

sub forward_difference{
    my($order, $numbers) = @_;
    if(!$order || @{$numbers} == 1){
        return $numbers;
    } 
    else{
        my $reduced = [];
        my $previous = $numbers->[0];
        for(my $i = 1; $i < @{$numbers}; $i++){
            push @{$reduced}, $numbers->[$i] - $previous;
            $previous = $numbers->[$i]; 
        }  
        forward_difference($order - 1, $reduced);  
    }  
    
} 


MAIN:{
    my $order = $ARGV[0];
    my @numbers = @ARGV[1 .. (@ARGV - 1)];
    my $reduced = forward_difference($order, \@numbers);  
    print pp $reduced; 
}
