use strict;
use warnings;
##
# Write a script to print decimal number 0 to 50 in octal.
##
MAIN:{
    for my $x (0..50){
        print "Decimal $x = Octal " . sprintf("%o", $x) . "\n";
    } 
}
