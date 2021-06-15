#!/usr/bin/perl

use strict;
use warnings;

my $F = $ARGV[0];
die "ERROR: Missing input file.\n" unless defined $F;
die "ERROR: Invalid file $F.\n" unless -f $F;

my $line_sum = 0;
open (my $fh, '<:encoding(utf8)', $F)
    or die "ERROR: Unable to open file $F: $!\n";

while (my $row = <$fh>) {
    chomp $row;
    my ($line_number) = split /,/,$row;
    $line_sum += $line_number;
}

close($fh);

# Sum of 1..15
my $expected = (15 * 16)/2;

print sprintf("Missing line: %d\n", $expected - $line_sum);
