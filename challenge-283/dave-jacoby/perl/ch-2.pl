#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures };

my @examples = (    # added a couple test entries

    [ 1, 2, 1, 0 ],
    [ 0, 3, 0 ],
);

for my $example (@examples) {
    my $input  = join ', ', $example->@*;
    my $output = digital_count_value($example) 
        ? 'true' : 'false';
    say <<"END";
    Input:  \@int = ($input)
    Output: $output
END
}

sub digital_count_value ($input) {
    my $s = -1 + scalar $input->@*;
    for my $i ( 0 .. $s ) {
        my $j = $input->[$i];
        my $k = scalar grep { $_ == $i } $input->@*;
        return 0 unless $j == $k;
    }
    return 1;
}
