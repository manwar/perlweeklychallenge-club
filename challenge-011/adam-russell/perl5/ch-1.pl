use strict;
use warnings;
##
# Write a script that computes the equal point in the Fahrenheit and Celsius 
# scales, knowing that the freezing point of water is 32 °F and 0 °C, and 
# that the boiling point of water is 212 °F and 100 °C.
# °F = (°C * 9/5) + 32
##
for my $c (-100 .. 100){
    my $f = ($c * (9/5)) + 32; 
    if($f == $c){ 
        print "°F = °C at $f\n";  
    }  
}
