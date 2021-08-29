use strict;
use warnings;
##
# You are given a list of intervals. Write a script 
# to determine conflicts between the intervals. 
##
sub conflicts{
    my @intervals = @_;
    my @conflicts;  
    @intervals = sort { $a->[1] <=> $b->[1] } @intervals; 
    {
        my $interval = pop @intervals;  
        my($i, $j) = @{$interval};  
        for $interval (@intervals){
            my($m, $n) = @{$interval}; 
            do { unshift @conflicts, [$i, $j]; last } if $i >= $m && $i <= $n;    
        }  
        redo if @intervals; 
    }
    return @conflicts;  
}

MAIN:{
    my(@Intervals);
    @Intervals = ([1, 4], [3, 5], [6, 8], [12, 13], [3, 20]);
    map { print "[" . join(", ", @{$_}) . "] " } conflicts(@Intervals);
    print "\n";  
    @Intervals = ([3, 4], [5, 7], [6, 9], [10, 12], [13, 15]);
    map { print "[" . join(", ", @{$_}) . "] " } conflicts(@Intervals);
    print "\n";  
}    
