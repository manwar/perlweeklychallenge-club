#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

my @examples = (qw{ d3 g5 e6 });

for my $example (@examples) {
    my $output = color_check($example);
    say <<"END";
    Input:  \@str = "$example"
    Output: $output
END
}

sub color_check ($input) {
    my ( $l, $n ) = split //, $input;
    my @lets = 'a' .. 'h';
    my %lets = map { $lets[$_] => $_ } 0 .. -1 + scalar @lets;
    return ( $lets{$l} + ( $n % 2 ) ) % 2 ? 'false' : 'true ';
}
