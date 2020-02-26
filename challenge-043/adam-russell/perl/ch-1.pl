use strict;
use warnings;
##
# You are given the numbers 1, 2, 3, 4 and 6. 
# Write a script to place these numbers in the 
# rings so that the sum of numbers in each ring 
# is exactly 11.       
##
use AI::Prolog;
use Data::Dump q/pp/; 
my $prolog = do{
    local $/;
    <DATA>;
}; 
$prolog = new AI::Prolog($prolog); 
$prolog->query("colors(Red, Green, Black, Yellow, Blue).");
my $result = $prolog->results;
my($red, $green, $black, $yellow, $blue) = @{$result}[1 .. @{$result} - 1];
print "Red: $red\nGreen: $green\nBlack: $black\nYellow: $yellow\nBlue: $blue\n";

__DATA__
member(X,[X|T]).
member(X,[H|T]) :- member(X,T).
colors(Red, Green, Black, Yellow, Blue) :-  
    member(Blue, [1,2,3,4,6]), 
    member(Yellow, [1,2,3,4,6]), 
    member(Green, [1,2,3,4,6]), 
    member(Red, [1,2,3,4,6]), 
    member(Black, [1,2,3,4,6]), 
    R = 11, R is 9 + Red,
    G = 11, G is 5 + Red + Green,
    B = 11, B is 8 + Blue,
    Y = 11, Y is 7 + Blue + Yellow,
    Bl = 11, Bl is Green + Yellow + Black. 
