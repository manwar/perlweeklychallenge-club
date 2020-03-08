#!perl6 
# Task 1 Challenge 049 Solution by kevincolyer
# Smallest Multiple
# Write a script to accept a positive number as command line argument 
# and print the smallest multiple of the given number consists of 
# digits 0 and 1.
# For example:
# For given number 55, the smallest multiple is 110 consisting of 
# digits 0 and 1.

my Int $z10;
sub MAIN(Int $number where * > 1) {
    for 1..Inf -> Int $zero-ones {
        # calculate all numbers with 0 or 1's in them (i.e. binary!)
        $z10=+$zero-ones.base(2);
        # use the binary string as a decimal value in trial division
        if $z10 %% $number {
            say "Smallest multiple of $number that consists of 0's and 1's is {$z10 / $number} gives {$z10} (found in $zero-ones iterations)";
            last;
        }
    }
}
