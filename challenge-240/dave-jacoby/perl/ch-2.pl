#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Algorithm::Permute;

my @examples = (

    [ 0, 2, 1, 5, 3, 4 ],
    [ 5, 0, 1, 2, 3, 4 ],
);
for my $e (@examples) {
    my @output = build_array( $e->@* );
    my @input  = $e->@*;
    my $output = join ', ', @output;
    my $input  = join ', ', @input;
    say <<~"END";
    Input:  \@int = ($input)
    Output: ($output)
    END
}

sub build_array (@int) {
    my $len  = -1 + scalar @int;
    my @copy = @int;
    my $p    = Algorithm::Permute->new( \@copy );
OUTER: while ( my @res = $p->next ) {
        for my $i ( 0 .. $len ) {
            next OUTER unless $res[$i] == $int[ $int[$i] ];
        }
        return @res;
    }
    return ();
}
