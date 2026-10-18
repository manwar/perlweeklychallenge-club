#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub to_complex($s) {
    # Convert the input string to a complex number"""
    if ( $s =~ /^(-?\d+)\+(\d+)i$/ ) {
        return $1, $2;
    }
    if ( $s =~ /^(-?\d+)\+\((-\d+)\)i$/ ) {
        return $1, $2;
    }
    die "Unexpected input: $s\n";
}

sub main ( $num1, $num2 ) {
    my ( $r1, $i1 ) = to_complex($num1);
    my ( $r2, $i2 ) = to_complex($num2);

    my $result_real = $r1 * $r2 - $i1 * $i2;
    my $result_imag = $r1 * $i2 + $i1 * $r2;
    if ( $result_imag >= 0 ) {
        say "$result_real+${result_imag}i";
    }
    else {
        say "$result_real+($result_imag)i";
    }
}

main(@ARGV);
