#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw(product reduce sum);

sub main {
    # Convert strings to integers, and get count of items
    my @n = @_;
    my $c = scalar(@n);

    # Calculate the different means
    my $am = sum(@n) / $c;
    my $gm = product(@n)**( 1 / $c );
    my $hm = $c / reduce { $a + ( $b == 0 ? 0 : 1 / $b ) } 0, @n;

    # Display results
    printf "AM = %.1f, GM = %.1f, HM = %.1f\n", $am, $gm, $hm;
}

main(@ARGV);