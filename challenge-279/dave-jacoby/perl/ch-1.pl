#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (
    {
        letters => [ 'R', 'E', 'P', 'L' ],
        weights => [ 3,   2,   1,   4 ],
    },
    {
        letters => [ 'A', 'U', 'R', 'K' ],
        weights => [ 2,   4,   1,   3 ],
    },
    {
        letters => [ 'O', 'H', 'Y', 'N', 'P', 'T' ],
        weights => [ 5,   4,   2,   6,   1,   3 ],
    }
);

for my $example (@examples) {
    my $output  = sort_letters($example);
    my $letters = join ', ', map { qq{'$_'} } $example->{letters}->@*;
    my $weights = join ', ', $example->{weights}->@*;
    say <<"END";
    Input:  \@letters = ($letters)
            \@weights = ($weights)
    Output: $output
END
}

sub sort_letters ($input) {
    my @output;
    for my $i ( 0..-1+scalar $input->{weights}->@*){
        my $w = $input->{weights}[$i];
        my $l = $input->{letters}[$i];
        @output[$w]= $l;
    }
    my $output = join '', grep { defined } @output;
    return $output;
}
