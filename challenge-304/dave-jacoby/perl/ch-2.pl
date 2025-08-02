#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ max sum0 };
use Carp;

my @examples = (

    { digits => [ 1, 12, -5, -6, 50, 3 ], n => 4 },
    { digits => [5],                      n => 1 },
);

for my $example (@examples) {
    my $n      = $example->{n};
    my @digits = $example->{digits}->@*;
    my $digits = join ', ', @digits;
    my $output = maximum_average($example);
    say <<"END";
    Input:  \@digits = ($digits), \$n = $n
    Output: $output
END
}

sub maximum_average($example) {
    my $n      = $example->{n};
    my @digits = $example->{digits}->@*;
    my @output;
    my $d = $#digits;

    for my $i ( 0 .. $d ) {
        my @slice = grep { defined } @digits[ $i .. $i + $n - 1 ];
        next unless $n == scalar @slice;
        push @output, average(@slice);
    }
    return max @output ;
}

sub average (@nums) {
    return ( sum0 @nums ) / ( scalar @nums );
}