=begin

    TASK #1 › Maximum Gap
    Submitted by: Mohammad S Anwar
    You are given an array of integers @N.
    
    Write a script to display the maximum difference between two successive elements once the array is sorted.
    
    If the array contains only 1 element then display 0.
    
    Example
        Input: @N = (2, 9, 3, 5)
        Output: 4
    
        Input: @N = (1, 3, 8, 2, 0)
        Output: 5
        
        Input: @N = (5)
        Output: 0

=end
=cut


use strict;
use warnings;
use Data::Dumper;


#Input
my @N = (2, 9, 3, 5);

my $result = 0;
my $sub = 0;

if (@N != 1) {
    my @sorted = sort { $a <=> $b } @N;
    for (my $i= 0; $i<@N-1; $i++) {
        $sub = $sorted[$i+1] - $sorted[$i];
        if ($sub > $result) {
            $result = $sub;
        }
    }
}
print "$result\n";








