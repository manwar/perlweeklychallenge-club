#!/usr/bin/perl

use strict;
use warnings;

use Text::CSV;

my $FILE = $ARGV[0];
die "ERROR: Missing input file.\n" unless defined $FILE;

my $csv = Text::CSV->new;

open(my $fh, '<:encoding(utf8)', $FILE)
    or die "ERROR: Unable to open $FILE: $!\n";

my $contents = [];
while (my $row = $csv->getline($fh)) {
    chomp $row;
    my $i = 0;
    foreach my $field (@$row) {
        push @{$contents->[$i++]}, $field;
    }
}

close($fh);

foreach my $row (@$contents) {
    print join(",", @$row), "\n";
}
