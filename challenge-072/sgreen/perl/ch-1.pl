#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub main (@) {
    my $N = shift;

    # Calculate N!
    my $total = 1;
    $total *= $_ for ( 1 .. $N );

    # Strip out everything except the last zeros (if any)
    # And display the length of the string
    $total =~ /^.*?(0*)$/;
    say length($1);
}

main(@ARGV);
