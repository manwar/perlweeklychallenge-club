=begin
    TASK #2 › Sum of Squares
    Submitted by: Mohammad Meraj Zia
    You are given a number $N >= 10.

    Write a script to find out if the given number $N is such that sum of squares of all digits is a perfect square. Print 1 if it is otherwise 0.

    Example
    Input: $N = 34
    Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2

    Input: $N = 50
    Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2

    Input: $N = 52
    Output: 0 as 5^2 + 2^2 => 25 + 4 => 29
    
=end
=cut

use warnings;
use strict;
use Data::Dumper;

my $input = '52';
my @arrayA = split(//, $input);
my $suma = 0;


foreach(my $i = 0; $i < @arrayA; $i++) {
    $suma += $arrayA[$i]**2
}  

my $result = sqrt $suma;
if ($result =~ /^\d+$/) {
    print "Ouput: 1";
}
else {
    print "Ouput: 0";
}


    

