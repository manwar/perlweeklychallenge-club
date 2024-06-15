#!/usr/bin/perl

#
# Copyright (C) 2024 Joelle Maslak
#

use JTM::Boilerplate 'script';

MAIN: {
    if ((scalar(@ARGV) != 2) or (length($ARGV[1]) != 1) or (length($ARGV[0]) < 1)) {
        help();
        exit(1);
    }

    calculate($ARGV[0], $ARGV[1]);
}

sub calculate($str, $char) {
    # Calculate the percentage that a character appears
    my $strlen = length($str);
    my $count = scalar(grep { $_ eq $char } split(//, $str));

    printf("Percentage of times character appears in string: %.0f%%\n", 100.0*$count/$strlen);
}

sub help() {
    print STDERR "Calculate the percent of a string that contains a character\n";
    print STDERR "You must provide two parameters:\n";
    print STDERR "\n";
    print STDERR "  ch-1.pl <string> <character>\n";
}