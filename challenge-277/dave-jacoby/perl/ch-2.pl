#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ min };

my @examples = (

    [ 1, 2, 3, 4, 5 ],
    [ 5, 7, 1, 7 ],
);

for my $input (@examples) {
    my @output = strong_pair( $input->@* );
    my $ints   = join ', ', $input->@*;
    my $output = scalar @output;
    my $pairs = join ', ', map { qq{($_)} } map { join ', ', $_->@* } @output;

    say <<"END";
        Input:  \@ints = ($ints)
        Output: $output

        Strong Pairs: $pairs
END
}

sub strong_pair (@ints) {
    my @output;
    my $top = -1 + scalar @ints;
    for my $i ( 0 .. $top ) {
        my $x = $ints[$i];
        for my $j ( $i + 1 .. $top ) {
            my $y   = $ints[$j];
            my $abs = abs $x - $y;
            my $min = min $x, $y;
            if ( $abs > 0 && $abs < $min ) {
                my @pair = sort $x, $y;
                push @output, \@pair;
            }
        }
    }

    # array cleanup - put in order, avoid duplicates
    my %hash;
    map { my $x = join ',', @$_; $hash{$x} = $_ } @output;
    return sort { $a->[0] <=> $b->[0] }
        sort { $a->[1] <=> $b->[1] } values %hash;
}
