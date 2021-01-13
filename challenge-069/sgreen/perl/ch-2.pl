#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub main() {
    my $string = "";
    for my $n ( 1 .. 30 ) {
        my $previous = $string;

        #Reverse the string
        $string = reverse($string);

        # Switch the digits
        $string =~ tr/01/10/;

        # Prefix by the original string, a zero and print it
        $string = "${previous}0$string";
        say "S$n = $string";
    }
}

main();
