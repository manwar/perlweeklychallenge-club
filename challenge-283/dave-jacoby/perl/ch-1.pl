#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ postderef say signatures state };

use List::Util qw{ uniq };

my @examples = (    # added a couple test entries

    [ 3, 3, 1 ], 
    [ 3, 2, 4, 2, 4 ], 
    [1], 
    [ 4, 3, 1, 1, 1, 4 ]
);

for my $example (@examples) {
    my $input = join ', ', $example->@*;
    my $output = unique_number($example);
    say <<"END";
    Input:  \@int = ($input)
    Output: $output
END
}

sub unique_number ($input) {
    my $hash;
    for my $i ( @$input ) {
        $hash->{$i}++;
    }
    my @results = grep {$hash->{$_} == 1 } keys %$hash;
    return shift @results;
}
