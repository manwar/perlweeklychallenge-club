#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ min sum };

my @input = ( [ 1, 1, 1 ], [ 1, 0, 5 ], [ 0, 2, 0 ], [ 0, 3, 0 ], );

for my $input (@input) {
    my $list   = join ', ', $input->@*;
    my $output = equal_distrib($input);
    say <<"END";
    Input:  \@list = ($list)
    Output: $output
END
}

sub equal_distrib ( $list, $level = 0, $steps = {} ) {
    my @output;

    # possible?
    my $sum = sum $list->@*;
    my $spaces = scalar $list->@*;
    return -1 unless 0 == $sum % $spaces;

    # test
    my $c = 0;
    for my $i ( 0 .. -1 + scalar $list->@* ) {
        $c++ if $list->[$i] == $list->[0];
    }
    return $level if $c == scalar $list->@*;

    # recurse
    for my $i ( 0 .. -2 + scalar $list->@* ) {
        for my $j ( 0 .. 1 ) {
            my $step = join ',', $list->@*;
            my %hash = $steps->%*;
            return if $hash{$step}++;

            if ($j) {    # move a digit up if possible
                my @copy = $list->@*;
                if ( $copy[$i] > 0 ) {
                    $copy[$i]--;
                    $copy[ $i + 1 ]++;
                    my $out = equal_distrib( \@copy, $level + 1, \%hash );

                    # say join ' ', '>', @copy, $out || 'BLANK';
                    if ( defined $out ) {
                        push @output, $out if $out > 0;
                    }
                }
            }
            else {    # move a digit down if possible
                my @copy = $list->@*;
                if ( $copy[ $i + 1 ] > 0 ) {
                    $copy[$i]++;
                    $copy[ $i + 1 ]--;
                    my $out = equal_distrib( \@copy, $level + 1, \%hash );

                    # say join ' ', '<', @copy, $out || 'BLANK';
                    if ( defined $out ) {
                        push @output, $out if $out > 0;
                    }
                }
            }
        }
    }
    return min @output;
}
