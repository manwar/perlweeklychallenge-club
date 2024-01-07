

use v5.38;
##
# You are given an array of alphanumeric strings.
# Write a script to return the maximum value of alphanumeric string in the given array.
# The value of alphanumeric string can be defined as
#     a) The numeric representation of the string in base 10 if it is made up of digits only.
#     b) otherwise the length of the string
##
sub alphanumeric_string_value{
    my @values = sort {$b <=> $a} map{
        /^\d*$/?0 + $_:length 
    } @_;   
    return $values[0];  
}

MAIN:{
    say alphanumeric_string_value qw/perl 2 000 python r4ku/;   
    say alphanumeric_string_value qw/001 1 000 0001/;   
}
