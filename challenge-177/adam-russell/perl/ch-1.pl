use strict;
use warnings;
##
# You are given a positive number, $n. Write a script to validate the given number against 
# the included check digit.
##
use boolean; 

my @damm_matrix;
$damm_matrix[0] = [0, 7, 4, 1, 6, 3, 5, 8, 9, 2];
$damm_matrix[1] = [3, 0, 2, 7, 1, 6, 8, 9, 4, 5];
$damm_matrix[2] = [1, 9, 0, 5, 2, 7, 6, 4, 3, 8];
$damm_matrix[3] = [7, 2, 6, 0, 3, 4, 9, 5, 8, 1];
$damm_matrix[4] = [5, 1, 8, 9, 0, 2, 7, 3, 6, 4];
$damm_matrix[5] = [9, 5 ,7, 8, 4, 0, 2, 6, 1, 3];
$damm_matrix[6] = [8, 4, 1, 3, 5, 9, 0, 2, 7, 6];
$damm_matrix[7] = [6, 8, 3, 4, 9, 5, 1, 0, 2, 7];
$damm_matrix[8] = [4, 6, 5, 2, 7, 8, 3, 1, 0, 9];
$damm_matrix[9] = [2, 3, 9, 6, 8, 1, 4, 7, 5, 0];

sub damm_validation{
    my($x) = @_;
    my @digits = split(//, $x);
    my $interim_digit = 0;
    while(my $d = shift @digits){
        $interim_digit = $damm_matrix[$d][$interim_digit];
    }
    return boolean($interim_digit == 0);
}

MAIN:{
    print damm_validation(5724) . "\n";
    print damm_validation(5727) . "\n";
}