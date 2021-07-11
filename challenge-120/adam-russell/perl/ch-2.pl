use strict;
use warnings;
##
# You are given time $T in the format hh:mm.
# Write a script to find the smaller angle formed 
# by the hands of an analog clock at a given time.
##
sub clock_angle{
    my($h, $m) = split(/:/, $_[0]);
    my $angle = abs(0.5 * (60 * $h - 11 * $m)); 
    $angle = 360 - $angle if $angle > 180; 
    return $angle;
}

MAIN:{
    my $T;
    $T = "03:10";  
    print clock_angle($T) . "\n";  
    $T = "04:00";  
    print clock_angle($T) . "\n";  
}
