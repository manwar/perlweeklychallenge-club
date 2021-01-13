#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub main (@) {
    # Get the string, and separate it by letter
    my $string  = shift;
    my @letters = split //, $string;

    # Count the number of times each character is used
    my %used = ();

    # Go through the letters
    for my $i ( 0 .. $#letters ) {
        # Count the letter
        $used{ $letters[$i] }++;

        # Work backwards finding the first unique character
        my $match = '#';
        for ( my $j = $i ; $j >= 0 ; $j-- ) {
            if ( $used{ $letters[$j] } == 1 ) {
                $match = $letters[$j];
                last;
            }
        }
        print $match;
    }
    print "\n";
}

main(@ARGV);

