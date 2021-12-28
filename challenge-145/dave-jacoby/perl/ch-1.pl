#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

use List::Util qw{ sum };

my @examples;
push @examples, [ [ 1, 2, 3 ], [ 4, 5, 6 ] ];
push @examples,
    [ [ map { int rand 10 } 1 .. 5 ], [ map { int rand 10 } 1 .. 5 ], ];

for my $e (@examples) {
    my $a = join ', ', $e->[0]->@*;
    my $b = join ', ', $e->[1]->@*;
    my $o = dot_product( $e->@* );
    say <<"END";
        \@a = ($a)
        \@b = ($b)
        \$dot_product = $o
END
}

sub dot_product ( $x, $y ) {
    return sum
        map { $x->[$_] * $y->[$_] }
        map { $_ - 1 } 1 .. scalar $x->@*;
}
