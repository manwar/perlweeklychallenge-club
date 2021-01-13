use strict;
use warnings;
##
# Write a script to display all Colorful Numbers with 3 digits.
# A number can be declared a "Colorful Number" when
# all the products of consecutive subsets of the digits
# are different.
##
use AI::Prolog;
MAIN:{
    my $prolog = do{
        local $/;
        <DATA>;
    };
    $prolog = new AI::Prolog($prolog);
    for my $n (100..999){
        my($x, $y, $z) = split(//, $n);
        $prolog->query("colorful($x, $y, $z).");
        my $result = $prolog->results;
        if($result){ 
            print "$n: colorful number\n";
        }
        else{
            print "$n: not a colorful number\n";
        }
    }
}

__DATA__
colorful(X, Y, Z) :-
    A is X * Y, 
    B is Y * Z, 
    C is X * Y * Z, 
    X \= Y,  
    Y \= Z,  
    X \= Z, 
    X \= A,   
    X \= B,   
    X \= C,
    Y \= A,   
    Y \= B,   
    Y \= C,
    Z \= A,   
    Z \= B,   
    Z \= C.  
