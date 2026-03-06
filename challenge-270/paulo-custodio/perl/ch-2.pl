#!/usr/bin/env perl

use Modern::Perl;

my($x, $y, @ints) = @ARGV;

say equalize($x, $y, @ints);

sub equalize {
    my($x, $y, @ints) = @_;

    my $cost = 0;
    @ints = sort {$a <=> $b} @ints;
    return $cost if !@ints;
    my $max = $ints[-1];

    while (@ints) {
        @ints = sort {$a <=> $b} @ints;
        @ints = grep {$_ != $max} @ints;
        last if !@ints;

        if (@ints == 1) {
            $ints[0]++;
            $cost += $x;
        }
        else {
            $ints[0]++;
            $ints[1]++;
            $cost += $y;
        }
    }

    return $cost;
}
