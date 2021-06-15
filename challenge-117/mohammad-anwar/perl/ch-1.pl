#!/usr/bin/perl

use strict;
use warnings;

my $F = $ARGV[0];
die "ERROR: Missing input file.\n" unless defined $F;
die "ERROR: Invalid file $F.\n" unless -f $F;

my $line_sum  = 0;
my $row_count = 0;
open (my $fh, '<:encoding(utf8)', $F)
    or die "ERROR: Unable to open file $F: $!\n";

while (my $row = <$fh>) {
    chomp $row;
    my ($line_number) = split /,/,$row;
    $line_sum += $line_number;
    $row_count++;
}

close($fh);

# Assuming one missing row in the file.
$row_count++;

# Now find the sum of line numbers.
my $expected = ($row_count * ($row_count + 1))/2;

print sprintf("Missing line: %d\n", $expected - $line_sum);
