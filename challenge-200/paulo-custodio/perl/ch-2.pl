#!/usr/bin/perl

# Challenge 200
#
# Task 2: Seven Segment 200
# Submitted by: Ryan J Thompson
# A seven segment display is an electronic component, usually used to display
# digits. The segments are labeled 'a' through 'g' as shown:
#
#
# Seven Segment
#
#
# The encoding of each digit can thus be represented compactly as a truth table:
#
# my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
# For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’ enabled.
#
# Write a program that accepts any decimal number and draws that number as a
# horizontal sequence of ASCII seven segment displays, similar to the following:
#
#
# -------  -------  -------
#       |  |     |  |     |
#       |  |     |  |     |
# -------
# |        |     |  |     |
# |        |     |  |     |
# -------  -------  -------
# To qualify as a seven segment display, each segment must be drawn (or not drawn)
# according to your @truth table.
#
# The number "200" was of course chosen to celebrate our 200th week!

use Modern::Perl;

my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

sub draw_number {
    my($num) = @_;
    my @num = split(//, $num);

    # draw a
    for my $digit (@num) {
        if ($truth[$digit] =~ /a/) { print " ####   "; } else { print "        "; }
    }
    print "\n";
    # draw f, b
    for (1..2) {
        for my $digit (@num) {
            if ($truth[$digit] =~ /f/) { print "#"; } else { print " "; }
            print "    ";
            if ($truth[$digit] =~ /b/) { print "#"; } else { print " "; }
            print "  ";
        }
        print "\n";
    }
    # draw g
    for my $digit (@num) {
        if ($truth[$digit] =~ /g/) { print " ####   "; } else { print "        "; }
    }
    print "\n";
    # draw e, c
    for (1..2) {
        for my $digit (@num) {
            if ($truth[$digit] =~ /e/) { print "#"; } else { print " "; }
            print "    ";
            if ($truth[$digit] =~ /c/) { print "#"; } else { print " "; }
            print "  ";
        }
        print "\n";
    }
    # draw d
    for my $digit (@num) {
        if ($truth[$digit] =~ /d/) { print " ####   "; } else { print "        "; }
    }
    print "\n";
}

draw_number(shift || 0);
