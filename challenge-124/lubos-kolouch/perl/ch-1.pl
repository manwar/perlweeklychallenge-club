#!/usr/bin/perl
use warnings;
use strict;

sub print_venus_symbol {

    # Top circle
    print "    ^^^^^\n";
    print "   ^     ^\n";
    print "  ^       ^\n";
    print " ^         ^\n" x 5;
    print "  ^       ^\n";
    print "   ^     ^\n";
    print "    ^^^^^\n";

    # Stem
    print "      ^\n" x 3;

    # Base
    print "    ^^^^^\n";
    print "      ^\n" x 2;
}

print_venus_symbol();
