#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is (excel_column("Z"),  26,  "Z  => 26");
is (excel_column("AB"), 28,  "AB => 28");
is (excel_column(28),  "AB", "28 => AB");

done_testing;

sub excel_column {
    my ($arg) = @_;

    if ($arg =~ /^\d+$/) {
        my $name = '';
        my @name = (0, 'A' .. 'Z');
        while ($arg > 26) {
            my $i = int $arg / 26;
            $name .= $name[$i];
            $arg  -= ($i * 26);
        }
        $name .= $name[$arg];

        return $name;
    }
    elsif ($arg =~ /^[A-Z]+$/i) {
        my $i = 0;
        my $b = 26;
        my $d = 0;
        foreach my $c (split //, scalar(reverse(uc $arg))) {
            $d += (ord($c) - ord("A") + 1) * ($b ** $i++);
        }

        return $d;
    }
    else {
        die "ERROR: Invalid column [$arg].\n";
    }
}
