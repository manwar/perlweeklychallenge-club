#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use JSON;
my $json = JSON->new;

my @examples;
push @examples, [ 1, 2 ];
push @examples, [ 2, 3 ];
push @examples, [ 2, 5 ];
push @examples, [ 5, 7 ];

for my $x (@examples) {
    say '-' x 20;
    my ( $u, $v ) = $x->@*;
    my @sequence = ulam( $u, $v );
    my $sequence = join ', ', sort { $a <=> $b } @sequence;
    say <<"END";
    Input:   \$u = $u, \$v = $v
    Output: $sequence
END
}

sub ulam ( $u = 1, $v = 2 ) {
    my %output;
    my @output;

    # cover the base cases
    $output{$u} = 1;
    $output{$v} = 1;

    my ($c) = sort { $b <=> $a } $u, $v;
    while (1) {
        $c++;

        # ensure that non-Ulam numbers ("exactly one way")
        # get weeded out
        map { delete $output{$_} } grep { $output{$_} > 1 }
            keys %output;
        @output = sort { $a <=> $b } keys %output;

        # testing early, because of the filter
        return @output if scalar @output == 10;

        for my $i ( 0 .. -2 + scalar @output ) {
            my $x = $output[$i];
            for my $j ( $i + 1 .. -1 + scalar @output ) {
                my $y = $output[$j];
                my $d = $x + $y;
                if ( $c == $d ) {
                    $output{$c}++;
                }
            }
        }
    }

    # "Remember the impossible scenario we never planned for?"
    return [];
}
