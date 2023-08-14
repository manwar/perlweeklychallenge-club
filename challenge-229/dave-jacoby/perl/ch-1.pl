#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw( sum0 );

my @examples = (

    [ "abc", "bce", "cae", ],
    [ "yxz", "cba", "mon", ],
);

for my $e (@examples) {
    my @array  = $e->@*;
    my $array  = join ', ', map { qq{"$_"} } @array;
    my $output = lex_order(@array);
    say <<~"END";
    Input:  \@int = ($array)
    Output: $output
    END
}

sub lex_order (@array) {
    my @output;
    for my $str (@array) {
        my $abc = join '', sort split //, $str;
        my $cba = join '', reverse sort split //, $str;
        next if $str eq $abc;
        next if $str eq $cba;
        push @output, $str;
    }
    my $output = scalar @output;
    return $output;
}
