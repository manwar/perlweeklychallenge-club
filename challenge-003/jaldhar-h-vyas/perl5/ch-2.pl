#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
sub usage {
    print <<"-USAGE-";
    Usage:
    $0 <number>

    <number>    the number of rows in the triangle
-USAGE-

    exit(1);
}

sub ptRow {
    my ($row, $col) = @_;

    if ($col == 1 || $col == $row) {
        return 1;
    }

    return ptRow($row - 1, $col - 1) + ptRow($row - 1, $col);
}

if (scalar @ARGV < 1) {
    usage();
}

my $height = $ARGV[0];

for my $row (1 .. $height) {
    for my $col (1 .. $row) {
        print ptRow($row, $col);
    }
    print q{ };
}

print "\n";

