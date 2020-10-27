#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

sub main {
    my $input = shift;
    die "You must specify an integer\n" unless $input;
    die "The value '$input' does not look like an integer\n"
      unless $input =~ /^-?[0-9]+$/;

    my ( $sign, $integer ) = ( $input =~ /^(-?)([0-9]+)$/ );
    my $number = $sign . reverse($integer);

    # WARNING: As noted in my blog post, this might be incorrect
    if ( $number >= -( 2**31 ) and $number <= 2**31 - 1 ) {
        say $number;
    }
    else {
        say 0;
    }
}

main(@ARGV);

