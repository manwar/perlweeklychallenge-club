#!/usr/bin/env perl

use Modern::Perl;

@ARGV==6 or die "usage: $0 x1 y1 x2 y2 x3 y3\n";
say are_colinear(@ARGV) ? "true" : "false";

sub are_colinear {
    my ($x1, $y1, $x2, $y2, $x3, $y3) = @_;

    my $double_area =  $x1 * ($y2 - $y3) +
                       $x2 * ($y3 - $y1) +
                       $x3 * ($y1 - $y2);

    return $double_area == 0 ? 1 : 0;
}
