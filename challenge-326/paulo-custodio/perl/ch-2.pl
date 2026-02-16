#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @output;
while (my($count, $num) = splice(@ARGV, 0, 2)) {
    push @output, ($num) x $count;
}
say join ", ", @output;
