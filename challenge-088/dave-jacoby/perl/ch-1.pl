#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use JSON;
use List::Util qw{ product };

my $json = JSON->new;
my @examples;
push @examples, [ 5, 2, 1, 4, 3 ];
push @examples, [ 2, 1, 4, 3 ];

if (@ARGV) {
    @examples = ();
    push @examples, [ map { int $_ } @ARGV ];
}

for my $example (@examples) {
    my $output->@* = array_of_products($example);
    say $json->encode($example);
    say $json->encode($output);
    say '';
}

sub array_of_products( $arrayref ) {
    my $end = -1 + scalar $arrayref->@*;
    my @output;
    for my $i ( 0 .. $end ) {
        push @output,
            product map { $arrayref->[$_] } grep { $_ != $i } 0 .. $end;
    }
    return @output;
}
