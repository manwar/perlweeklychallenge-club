#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;
use Try::Tiny;

die "No argument.\n" unless @ARGV;
my @fields = ($ARGV[0] =~ /^([12])(\d\d)([01]\d)([0-3]\d)$/a)
    or die "Invalid format of argument\n";
die "Bad month $fields[2] - should be 01 to 12\n"
    unless $fields[2] > 0 && $fields[2] < 13;
die "Bad day $fields[3] - should be 01 to 31\n"
    unless $fields[3] > 0 && $fields[3] < 32;

my $date = join '', 21 - $fields[0],  @fields[1,2,3];
my $tp;

try {
    $tp = Time::Piece->strptime ($date, "%Y%m%d");
} catch {
    die "$fields[3] is not a valid day that month\n";
};

print $tp->strftime ("%A %d %b %Y\n");
