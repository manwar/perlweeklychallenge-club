#!/usr/bin/perl

#
# Perl Weekly Challenge - 072
#
# Task #2: Lines Range
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-072
#

use strict;
use warnings;

my $F = $ARGV[0];
my $A = $ARGV[1];
my $B = $ARGV[2];

lines_range($F, $A, $B);

#
#
# METHOD

sub lines_range {
    my ($file, $a, $b) = @_;

    die "ERROR: Invalid file [$file].\n"     unless (-e $file && -f _ && -r _ && -T _);
    die "ERROR: Missing A.\n"                unless defined $a;
    die "ERROR: Missing B.\n"                unless defined $b;
    die "ERROR: Invalid range [$a \- $b].\n" unless ($a <= $b);

    open(my $F, "<", $file) || die "ERROR: Failed to open [$!]\n";
    my @lines = <$F>;
    close($F);

    print $lines[$_] for --$a..--$b;
}
