#!perl6
# Task 2 Challenge 059 Solution by kevincolyer

#TASK #2 › Bit Sum
#Reviewed by Ryan Thompson
#Helper Function
#For this task, you will most likely need a function f(a,b) which returns the count of different bits of binary representation of a and b.
#
#For example, f(1,3) = 1, since:
#
#Binary representation of 1 = 01
#
#Binary representation of 3 = 11
#
#There is only 1 different bit. Therefore the subroutine should return 1. Note that if one number is longer than the other in binary, the most significant bits of the smaller number are padded (i.e., they are assumed to be zeroes).
#
#Script Output
#You script should accept n positive numbers. Your script should sum the result of f(a,b) for every pair of numbers given:
#
#For example, given 2, 3, 4, the output would be 6, since f(2,3) + f(2,4) + f(3,4) = 1 + 2 + 3 = 6

# F XORs bits then counts them by mask of bit one, shifts left, ends when empty

use Test;

subset PosInt of Int where * >=0 ;

sub f(PosInt $a, PosInt $b) {
    my Int $count=0;
    my Int $bits = $a +^ $b;
    while $bits>0 {
        $count+= $bits +& 1;
        $bits=$bits +> 1;
    }
    return $count;
}

multi MAIN('test') {
    is f(1,3),1,"example";
    is f(2,3),1,"example 2";
    is f(2,4),2,"example 2";
    is f(4,3),3,"example 2";
    is f(2,3)+f(2,4)+f(3,4),6,"example 2";
}

#|Sum the different bits of pairs of positive ints...
multi MAIN(+@n) {
    die "Need pairs of numbers, got {@n.elems}" unless @n %% 2 && @n.elems > 0;
    say [+] gather for @n -> $a,$b { take f($a,$b) };
}

# http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
# faster solution
# for 32 bits
# c = (v & 0x55555555) + ((v >> 1) & 0x55555555);
# c = (c & 0x33333333) + ((c >> 2) & 0x33333333);
# c = (c & 0x0F0F0F0F) + ((c >> 4) & 0x0F0F0F0F);
# c = (c & 0x00FF00FF) + ((c >> 8) & 0x00FF00FF);
# c = (c & 0x0000FFFF) + ((c >> 16)& 0x0000FFFF);
