#!/usr/bin/env perl

use Modern::Perl;

# parse input
my($rows, $cols) = split ' ', <>;
my @ops;
while (<>) {
    push @ops, [split ' ', $_];
}

my @m = do_ops($rows, $cols, @ops);
my $odd_cells = count_odd_cells(@m);
say $odd_cells;

sub do_ops {
    my($rows, $cols, @ops) = @_;
    for (0 .. $rows-1) {
        push @m, [(0) x $cols];
    }
    for (@ops) {
        my($row, $col) = @$_;
        # increment row
        for my $c (0 .. $cols-1) {
            $m[$row][$c]++;
        }
        # increment col
        for my $r (0 .. $rows-1) {
            $m[$r][$col]++;
        }
    }
    return @m;
}

sub count_odd_cells {
    my(@m) = @_;
    my $count = 0;
    for my $row (@m) {
        for my $col (@$row) {
            $count++ if $col % 2 == 1;
        }
    }
    return $count;
}
