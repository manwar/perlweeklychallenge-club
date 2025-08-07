#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    [ 1, 0, 2, 3, 0, 4, 5, 0 ],
    [ 1, 2, 3 ],
    [ 1, 2, 3, 0 ],
    [ 0, 0, 1, 2 ],
    [ 1, 2, 0, 3, 4 ],

);

for my $input (@examples) {
    my $str    = join ',', $input->@*;
    my @output = duplicate_zeroes( $input->@* );
    my $output = join ',', @output;
    say <<"END";
    Input:  \@str = ($str)
    Output:        ($output)
END
}

sub duplicate_zeroes (@ints) {
    my @output;
    my $l = $#ints;
    for my $i ( 0 .. $l ) {
        my $n = $ints[$i];
        my $o = $#output;
        push @output, $n if $#output < $l;
        push @output, $n if $n == 0 && $#output < $l;
    }
    return @output;
}
