=begin
You are given a positive integer, $int.

Write a script to return the number of beautiful arrangements that you can construct.

A permutation of n integers, 1-indexed, is considered a beautiful arrangement
if for every i (1 <= i <= n) either of the following is true:

1) perm[i] is divisible by i
2) i is divisible by perm[i]
Example 1
Input: $n = 2
Output: 2

1st arrangement: [1, 2]
    perm[1] is divisible by i = 1
    perm[2] is divisible by i = 2
2nd arrangement: [2, 1]
    perm[1] is divisible by i = 1
    i=2 is divisible by perm[2] = 1
Example 2
Input: $n = 1
Output: 1
Example 3
Input: $n = 10
Output: 700
=cut

use strict;
use warnings;

# Declare global variables for n, count, and used
our $n;
our $count = 0;
our @used;

sub beautifulArrangements {
    my ($input_n) = @_;
    $n = $input_n;  # Set the global $n
    @used = (0) x ($n + 1);  # Initialize the used array
    
    # Call the backtracking function starting at position 1
    backtrack(1);
    
    return $count;
}

# Helper recursive function to check and count arrangements
sub backtrack {
    my ($pos) = @_;

    if ($pos > $n) {
        $count++;
        return;
    }

    for my $i (1..$n) {
        # Skip if the number is already used
        next if $used[$i];
        
        if ($i % $pos == 0 || $pos % $i == 0) {
            $used[$i] = 1;
            backtrack($pos + 1);  # Recur for the next position
            $used[$i] = 0;  # Backtrack
        }
    }
}

my @cases = (2,1,10);

foreach(@cases){
    $count = 0;
    my $result = beautifulArrangements($_);
    print "For n = $_, the beautiful arrangements are : $result \n";
}
