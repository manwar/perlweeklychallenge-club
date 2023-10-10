#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ 1, 2,  3, 4, 5 ],
    [ 1, 1,  1, 1, 1 ],
    [ 0, -1, 1, 2 ],
);

for my $e (@examples) {
    my @output = running_sum( $e->@* );
    my $input  = join ', ', $e->@*;
    my $output = join ', ', @output;
    say <<~"END";
    Input:  \@int = ($input)
    Output: ($output)
    END
}

sub running_sum (@int) {
    my $c      = 0;
    my @output = map { $c += $_; $c } @int;
    return @output;
}
