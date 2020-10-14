#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use List::Util qw(min);

sub main {
    my @values  = @_;
    my @factors = ();

    die "You must specify at least two values\n" if scalar(@values) < 2;
    foreach (@values) {
        die "Value '$_' is not a positive number\n"
          unless /^[1-9][0-9]*$/;
    }

    my $min = min(@values);
  OUTER: foreach my $number ( 1 .. $min ) {
        foreach my $value (@values) {
            next OUTER if $value % $number;
        }

        push @factors, $number;
    }

    say join ', ', @factors;

}

main(@ARGV);
