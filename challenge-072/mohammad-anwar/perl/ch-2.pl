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

print lines_range($F, $A, $B), "\n";

#
#
# METHOD

sub lines_range {
    my ($file, $a, $b) = @_;

    die "ERROR: Invalid file [$file].\n"     unless (-e $file && -f _ && -r _ && -T _);
    die "ERROR: Missing A.\n"                unless defined $A;
    die "ERROR: Missing B.\n"                unless defined $B;
    die "ERROR: Invalid range [$A \- $B].\n" unless ($A <= $B);

    open(my $F, "<", $file) || die "ERROR: Failed to open [$!]\n";
    my @lines = <$F>;
    close($F);

    print $lines[$_] for $A-1..$B-1;
}
