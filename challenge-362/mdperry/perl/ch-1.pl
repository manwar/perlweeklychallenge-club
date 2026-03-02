#!/usr/bin/env perl

use v5.38;

my @words = qw/ abca xyz code hello a /;

foreach my $word ( @words ) {
    my @letters = split( '', $word );

    my $output = q{};

    foreach my $i ( 0..$#letters ) {
        $output .= $letters[$i] x ($i + 1);
    }

    print "Input: \"", $word, "\"\n";
    print "Output: \"", $output, "\"\n\n";

}

exit;

