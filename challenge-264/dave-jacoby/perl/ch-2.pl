#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (
    { source => [ 0, 1, 2, 3, 4 ], indices => [ 0, 1, 2, 2, 1 ] },
    { source => [ 1, 2, 3, 4, 0 ], indices => [ 0, 1, 2, 3, 0 ] },
    { source => [1],               indices => [0] },
    { source => [ 9, 0, 1, 2, 5 ], indices => [ 0, 1, 2, 1, 2 ] },
);

for my $example (@examples) {
    my @output  = target_array($example);
    my $output  = join ', ', @output;
    my $source  = join ', ', $example->{source}->@*;
    my $indices = join ', ', $example->{indices}->@*;

    say <<"END";
        Input: \@source  = ($source)
               \@indices = ($indices)
        Output: [ $output ]
END
}

sub target_array ($obj) {
    my @source  = $obj->{source}->@*;
    my @indices = $obj->{indices}->@*;
    my @target;
    for my $k ( 0 .. $#source ) {
        my $s     = $source[$k];
        my $i     = $indices[$k];
        my @input = ($s);
        push @input, $target[$i]
            if defined $target[$i];
        splice( @target, $i, 1, @input );
    }
    return @target;
}
