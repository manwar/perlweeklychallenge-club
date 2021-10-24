=begin

    TASK #1 › Middle 3-digits
    Submitted by: Mohammad S Anwar
    You are given an integer.

    Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.

        Example 1
            Input: $n = 1234567
            Output: 345
        Example 2
            Input: $n = -123
            Output: 123
        Example 3
            Input: $n = 1
            Output: too short
        Example 4
            Input: $n = 10
            Output: even number of digits

=end
=cut


use strict;
use warnings;
use Data::Dumper;

my $input = '1234567';

# Convert input into array
my @array = split(//, abs($input));

checkInputs();

sub checkInputs {
    if (@array == 3){  
    my $result = join( '', @array );
        print("$result\n");
    }
    elsif(@array % 2 == 0){
        print("Even number of digits\n");
    }
    elsif (@array > 3){
            obtainDigits();
    }
    elsif (@array < 3){
        print("too short\n");
    }
}

sub obtainDigits{
    # remove one element from the last of the array.
    pop(@array);

    # remove one element from the beginning of the array.
    shift(@array);
    
    checkInputs();
}


















