=begin
You are given a binary array.

Write a script to return an array of booleans where the partial binary number up to that point is prime.

Example 1
Input: @binary = (1, 0, 1)
Output: (false, true, true)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 0): 2 - prime
(1, 0, 1): 5 - prime
Example 2
Input: @binary = (1, 1, 0)
Output: (false, true, false)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 1): 3 - prime
(1, 1, 0): 6 - not prime
Example 3
Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
Output: (false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)
=cut

use strict;
use warnings;

my @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1); # Example input
my @output = binary_prime(@binary);

print "Input: @binary\n";
print "Output: (@output)\n";

sub IsPrime {
    my ($num) = @_;
    return 0 if $num < 2;           
    return 1 if $num == 2;       
    return 0 if $num % 2 == 0;       
    
    for (my $i = 3; $i * $i <= $num; $i += 2) {
        return 0 if $num % $i == 0;  
    }
    return 1;               
}

sub binary_prime {
    my (@binary) = @_;
    my @result;

    my $partial_number = 0;
    for my $bit (@binary) {
        $partial_number = ($partial_number << 1) | $bit; # Calculate partial binary number
        push @result, IsPrime($partial_number) ? 'true' : 'false';
    }

    return @result;
}

