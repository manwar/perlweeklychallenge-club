#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'sum';

@ARGV==2 or die "usage: $0 string k\n";
my($string, $k) = @ARGV;

say compute($string, $k);

sub compute {
    my($string, $k) = @_;

    # remove non-lower-case-letters
    $string =~ s/[^a-z]+//g;

    # convert to digits
    $string =~ s/(.)/ord($1) - ord("a") + 1/ge;

    # sum digits
    for (1 .. $k) {
        $string = sum(split(//, $string));
    }

    return 0+$string;
}
