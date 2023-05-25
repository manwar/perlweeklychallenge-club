#!/usr/bin/perl
use strict;
use warnings;

open my $fh, '<', 'input.txt' or die $!;

my @lines = <$fh>;

chomp(@lines);

my @fields = map { [split /,/] } @lines;

my $transposed = [];

for my $row (@fields) {
    for my $column (0 .. $#{$row}) {
        push @{$transposed->[$column]}, $row->[$column];
    }
}

open my $fh_out, '>', 'transposed_input.txt' or die $!;

for my $row (@$transposed) {
    print $fh_out join(',', @$row), "\n";
}

close $fh;
close $fh_out;

