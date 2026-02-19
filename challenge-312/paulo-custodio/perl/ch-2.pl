#!/usr/bin/env perl

use Modern::Perl;

say box_with_3_colors(shift // "");

sub box_with_3_colors {
    my($spec) = @_;
    my %boxes;
    while ($spec =~ /([RGB])(\d)/g) {
        $boxes{$2}{$1}++;
    }

    my $count = 0;
    for my $box (keys %boxes) {
        if ($boxes{$box}{R} && $boxes{$box}{G} && $boxes{$box}{B}) {
            $count++;
        }
    }
    return $count;
}
