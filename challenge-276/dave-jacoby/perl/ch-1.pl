#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (

    [ 12, 12, 30, 24, 24 ],
    [ 72, 48, 24, 5 ],
    [ 12, 18, 24 ],
);

for my $example (@examples) {
    my $output = complete_day($example);
    my $input = join ', ', $example->@*; 
        say <<~"END";
            Input:  \@hours = ($input)
            Output: $output
    END
}

sub complete_day ($durations) {
    my @output;
    my @durations = $durations->@*;
    for my $i ( 0 .. -1 + scalar @durations ) {
        for my $j ( $i + 1 .. -1 + scalar @durations ) {
            my $d = $durations[$i] + $durations[$j];
            push @output, [ $durations[$i], $durations[$j] ] if $d % 24 == 0;
        }
    }
    return scalar @output;
}
