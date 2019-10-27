#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

if ( @ARGV != 2 ) { die("Provide letters to use and (optionally) filename") }

MAIN: {
    if ( check_for_div_by_zero(@ARGV) ) {
        say "Denominator is zero";
    } else {
        say "Denominator is not zero";
    }
}

sub check_for_div_by_zero ( $top, $bottom ) {
    local $@;
    my $result =
      eval { use warnings FATAL => 'all'; $top / $bottom };    # Make things like "1 / abc" fatal.

    if ( defined($result) ) {
        return;
    } elsif ( $@ =~ /^Illegal division by zero / ) {
        return 1;
    } else {
        die($@);
    }
}

