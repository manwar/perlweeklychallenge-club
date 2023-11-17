use v5.38;
##
# Given a string containing digits 0-9 only write a script to find out 
# if the given string is additive number. An additive number is a 
# string whose digits can form an additive sequence.
##
use Graph;  
use boolean;  
use Data::Dump q/pp/;  
sub additive_number{
    my($digits) = @_; 
    my @numbers;
    my $graph = Graph->new();  
    do{
        my $i = $_;   
        $numbers[$i] = [];  
	push @{$numbers[$i]}, substr($digits, $i, $_) for 1 .. length($digits) - $i;     
    } for 0 .. length($digits) - 1; 
    my @last_numbers = map {pop @{$numbers[$_]}} 0 .. @numbers - 1;  
}

MAIN:{
    say additive_number 112358;  
    say additive_number 199100199;  
}
