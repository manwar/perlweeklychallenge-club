#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = ( 
    [ 2, 7, 4, 1, 8, 1 ], 
    [1], 
    [ 1, 1 ],
);

for my $example (@examples) {
    my $output = last_member( $example->@* );
    my $e = join ', ', $example->@*;
    say <<~"END";
        Input: \@ints = ($e);
        Output: $output
    END
}

sub last_member( @ints) {
    while ( scalar @ints > 1 ) {
        @ints = reverse sort @ints;
        my $x = shift @ints;
        my $y = shift @ints;
        push @ints, $x - $y if $x != $y;
    }
    return scalar @ints;
}
