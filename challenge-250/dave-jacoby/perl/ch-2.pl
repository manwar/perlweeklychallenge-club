#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max };

my @examples = (

    [ "perl", "2", "000", "python", "r4ku" ],
    [ "001",  "1", "000", "0001" ],
);

for my $e (@examples) {
    my $input = join ', ', map {qq{"$_"}} $e->@*;
    my $output = alphanumeric_string_value( $e->@* );

    say <<~"END";
    Input:  \@alphanumstr = ($input)
    Output: $output
    END
}

sub alphanumeric_string_value (@array) {
    my @output;
    for my $s (@array) {
        no warnings;
        my $n = 0;
        if   ( $s =~ /\d/ ) { $n = 0 + $s; }
        else                { $n = length $s; }
        push @output, $n;
    }
    return max @output;
}
