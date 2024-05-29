#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ sum0 };

my @examples = (

    [ 0,    1,   2,   3,   4, 5, 6, 7, 8 ],
    [ 1024, 512, 256, 128, 64 ],
);

for my $example (@examples) {
    my @output = sort sb1 sort numeric $example->@*;
    my $input  = join ', ', $example->@*;
    my $output = join ', ', @output;

    say <<"END";
        Input:  \@ints = ($input)
        Output: $output
END
}

sub numeric {
    return $a <=> $b ;
}

sub sb1 {
    my $A  = sprintf '%b', $a;
    my $B  = sprintf '%b', $b;
    my $da = sum0 split //, $A;
    my $db = sum0 split //, $B;
    return -1 if $da < $db;
    return 1  if $da > $db;
    return 0;
}

