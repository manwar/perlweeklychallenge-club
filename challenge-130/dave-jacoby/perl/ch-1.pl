#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

use List::Util qw{ uniq };

use JSON;
my $json = JSON->new;

my @examples;
push @examples, [ 2, 5, 4, 4, 5, 5, 2 ];
push @examples, [ 1, 2, 3, 4, 3, 2, 1, 4, 4 ];

for my $e (@examples) {
    my $i = join ', ', $e->@*;
    my $o = odd_numbers( $e->@* );
    say "INPUT:  ( $i )";
    say "OUTPUT: $o";
    say '';
}

sub odd_numbers( @array ) {
    my $x;
    map { $x->{$_}++ } @array;
    my ($o) =
        grep { 0 != $x->{$_} % 2 } uniq sort @array;
    return $o;
}
