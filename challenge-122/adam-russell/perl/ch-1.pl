use strict;
use warnings;
##
# You are given a stream of numbers, @N.
# Write a script to print the average of the stream at every point.  
##
sub moving_average{
    my $n = 0; 
    my $sum = 0; 
    {
        $n += 1;
        $sum += shift; 
        print $sum / $n; 
        print ", " if @_;
        redo if @_; 
    } 
    print "\n";  
}


MAIN:{
    my @N;
    for(my $i = 10; $i < 1_000_000; $i += 10){
        push @N, $i; 
    } 
    moving_average(@N);
}
