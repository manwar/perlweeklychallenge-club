=begin

    TASK #1 › Add Binary
    Submitted by: Mohammad S Anwar
    You are given two decimal-coded binary numbers, $a and $b.

    Write a script to simulate the addition of the given binary numbers.

    The script should simulate something like $a + $b. (operator overloading)

        Example 1
            Input: $a = 11; $b = 1;
            Output: 100
        Example 2
            Input: $a = 101; $b = 1;
            Output: 110
        Example 3
            Input: $a = 100; $b = 11;
            Output: 111
=end
=cut


use strict;
use warnings;

my $a = 11; 
my $b = 1;

# binary to decimal, add, decimal to binary
my $result = sprintf ("%b",eval("0b$a") + eval("0b$b"));
print "$result\n";