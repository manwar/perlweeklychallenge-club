=begin
    TASK #1 › Count Numbers
    Submitted by: Mohammad S Anwar
    You are given a positive integer $N.

    Write a script to print count of numbers from 1 to $N that don’t contain digit 1.

    Example
    Input: $N = 15
    Output: 8

        There are 8 numbers between 1 and 15 that don't contain digit 1.
        2, 3, 4, 5, 6, 7, 8, 9.

    Input: $N = 25
    Output: 13

        There are 13 numbers between 1 and 25 that don't contain digit 1.
        2, 3, 4, 5, 6, 7, 8, 9, 20, 22, 23, 24, 25.
    
=end
=cut

use strict;
use warnings;
use Data::Dumper;

my $N = 15;
my $counter = 0;

for my $iter (1 .. $N) {
    if ( $iter !~ /1+/) {
        $counter++;
    }
}
print("Output: $counter\n");