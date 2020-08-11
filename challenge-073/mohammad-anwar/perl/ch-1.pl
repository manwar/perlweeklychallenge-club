#!/usr/bin/perl

#
# Perl Weekly Challenge - 073
#
# Task #1: Min Sliding Window
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073
#

use strict;
use warnings;
use List::Util qw(min);

my $A = $ARGV[0] || "1, 5, 0, 2, 9, 3, 7, 6, 4, 8";
my $S = $ARGV[1] || 3;

print "$A\n";
print join ("\n", (join ', ', @{min_sliding_window($A, $S)}), "");

#
#
# METHOD

sub min_sliding_window {
    my ($list, $size) = @_;

    die "ERROR: Missing list.\n"
        unless defined $list;
    die "ERROR: Invalid list [$list].\n"
        unless ($list =~ /^[\-?\d\,?\s?]+$/);

    $list =~ s/\s//g;
    $list = [ split /\,/, $list ];

    die "ERROR: Missing size.\n"
        unless defined $size;
    die "ERROR: Invalid size [$size].\n"
        unless (($size >= 2) && ($size - 1 <= $#$list));

    my $index = 0;
    my @min_sliding_window = ();
    while ($index + $size - 1 <= $#$list) {
        push @min_sliding_window,
        min ( map { $list->[$_] } $index .. $index + $size - 1 );
        $index++;
    }

    return \@min_sliding_window;
}
