#!/usr/bin/perl

# Challenge 003
#
# Challenge #2
# Create a script that generates Pascal Triangle. Accept number of rows from
# the command line. The Pascal Triangle should have at least 3 rows. For more
# information about Pascal Triangle, check this wikipedia page.

use strict;
use warnings;
use 5.030;

my($rows) = @ARGV;

draw_pascal($rows);

sub draw_pascal {
    my($rows) = @_;
    my @row = (1);
    say " " x ($rows-1), "@row";
    for my $row (1 .. $rows-1) {
        # compute next row
        my @next = (1);
        for my $i (0 .. $#row-1) {
            push @next, $row[$i]+$row[$i+1];
        }
        push @next, 1;
        @row = @next;

        say " " x ($rows-$row-1), "@row";
    }
}
