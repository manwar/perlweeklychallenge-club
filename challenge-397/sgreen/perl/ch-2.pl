#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub calc_binary_reflection($i) {
    # Reverse the binary representation and return the resulting integer
    my $b = sprintf "%b", $i;
    return oct( "0b" . reverse($b) );
}

sub main (@ints) {
    my @sorted_ints = sort {
        calc_binary_reflection($a) <=> calc_binary_reflection($b) || $a <=> $b
    } @ints;

    say "(" . join( ", ", @sorted_ints ) . ")";
}

main(@ARGV);
