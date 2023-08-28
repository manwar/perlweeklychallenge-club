#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw( min max );

my @examples = (

    [ 3, 2, 1, 4 ],
    [ 3, 1 ],
    [ 2, 1, 3 ],
);

for my $e (@examples) {
    my @input  = $e->@*;
    my $input  = join ', ', @input;
    my @output = not_min_max(@input);
    my $output;
    say join ' ', @output;
    if ( $output[0] == -1 ) {
        $output = $output[0];
    }
    else {
        $output = join ', ', @output;
        $output = qq{($output)};
    }
    say <<~"END";
    Input:  \@ints = ($input)
    Output: $output
    END
}

sub not_min_max (@array) {
    my $min    = min @array;
    my $max    = max @array;
    my @output = grep { $_ != $min } grep { $_ != $max } @array;
    return @output if @output;
    return -1;
}
