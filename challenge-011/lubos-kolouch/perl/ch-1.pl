#!/usr/bin/perl
use strict;
use warnings;

my $fahrenheit;
my $celsius;

for ( $fahrenheit = -100 ; $fahrenheit <= 212 ; $fahrenheit++ ) {
    $celsius = ( $fahrenheit - 32 ) * 5 / 9;
    if ( $fahrenheit == $celsius ) {
        print
"The equal point in the Fahrenheit and Celsius scales is $fahrenheit °F and $celsius °C.\n";
        last;
    }
}
