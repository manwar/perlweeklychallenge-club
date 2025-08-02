#!/usr/bin/perl

#
# Copyright (C) 2024 Joelle Maslak
#

use JTM::Boilerplate;

MAIN: {
    if ((scalar(@ARGV) != 1)) {
        help();
        exit(1);
    }

    calculate($ARGV[0]);
}

sub calculate($str) {
    # Calculate the percentage that a character appears
    my $check = $str =~ m/^[^b]*b(?!a)/;
    say("Output: " . ($check ? "true" : "false"));
}

sub help() {
    print STDERR "Calculate whether there is a 'b' in a string where the first 'b' isn't followed by an 'a'\n";
    print STDERR "You must provide one parameter:\n";
    print STDERR "\n";
    print STDERR "  ch-2.pl <string>\n";
}
