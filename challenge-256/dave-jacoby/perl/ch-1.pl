#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ "ab", "de", "ed", "bc" ],
    [ "aa", "ba", "cd", "ed" ],
    [ "uv", "qp", "st", "vu", "mn", "pq" ],
);

for my $example (@examples) {
    my $input  = join ', ', map { qq {"$_"} } $example->@*;
    my $output = maximum_pairs( $example->@* );

    say <<~"END";
    Input:  \@words = ($input)
    Output: $output
    END
}

sub maximum_pairs (@input) {
    my %hash;
    map {
        my $munge = join '', sort split //, $_;
        $hash{$munge}++
    } @input;
    return scalar grep { $_ > 1 } values %hash;
}
