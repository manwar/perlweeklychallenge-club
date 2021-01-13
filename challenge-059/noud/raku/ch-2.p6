# Helper Function
#
# For this task, you will most likely need a function f(a,b) which returns the
# count of different bits of binary representation of a and b.
#
# For example, f(1,3) = 1, since:
#
# Binary representation of 1 = 01
# Binary representation of 3 = 11
#
# There is only 1 different bit. Therefore the subroutine should return 1. Note
# that if one number is longer than the other in binary, the most significant
# bits of the smaller number are padded (i.e., they are assumed to be zeroes).
#
# Script Output
#
# You script should accept n positive numbers. Your script should sum the
# result of f(a,b) for every pair of numbers given:
# For example, given 2, 3, 4, the output would be 6, since f(2,3) + f(2,4) +
# f(3,4) = 1 + 2 + 3 = 6

sub f($a, $b) {
    return [+] ($a +^ $b).base(2).comb;
}

sub pair-sum(@a) {
    return [+] @a.combinations(2).map({ f($_[0], $_[1]); });
}

say pair-sum([2, 3]);
say pair-sum([2, 3, 4]);
say pair-sum([2, 3, 4, 5]);
say pair-sum([2, 3, 4, 5, 6]);
say pair-sum([2, 3, 4, 5, 6, 7]);
say pair-sum([2, 3, 4, 5, 6, 7, 8]);
say pair-sum([2, 3, 4, 5, 6, 7, 8, 9]);
say pair-sum([2, 3, 4, 5, 6, 7, 8, 9, 10]);

# Note: This sequence is unknown in the online encyclopedia of integer
# sequences (OEIS). I'm surprised it's not in there. Is this pair-sum function
# somehow a well know function? If it isn't I think it's a good idea to add it
# to the OEIS.
