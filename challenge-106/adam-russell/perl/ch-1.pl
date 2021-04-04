use strict;
use warnings;
##
# You are given an array of integers @N.
# Write a script to display the maximum 
# difference between two successive elements 
# once the array is sorted.
##
sub max_difference_sorted{
    my(@sorted) = @_;
    return 0 if(@sorted == 1);
    my $x = $sorted[1] - $sorted[0];  
    my $y = max_difference_sorted(@sorted[1 .. @sorted - 1]);   
    return ($x > $y)? $x: $y; 
}

sub max_difference{
    my (@numbers) = @_;
    return max_difference_sorted(
        sort { $a <=> $b } @numbers
    ); 
}

MAIN:{
    my (@N);
    @N = (2, 9, 3, 5);
    print max_difference(@N) . "\n"; 
    @N = (1, 3, 8, 2, 0); 
    print max_difference(@N) . "\n"; 
    @N = (5);
    print max_difference(@N) . "\n"; 
}
