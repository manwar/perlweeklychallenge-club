#!/usr/bin/perl

use strict;
use warnings;

my @messages = (
    'P + 2 l ! a t o',
    '1 e 8 0 R $ 4 u',
    '5 - r ] + a > /',
    'P x w l b 3 k \\',
    '2 e 3 5 R 8 y u',
    '< ! r ^ ( ) k 0'
);

my $table = [];
foreach my $message (@messages) {
    my $column = 0;
    foreach my $char (split /\s/, $message) {
        $table->[$column++]->{$char}++;
    }
}

map { print [ sort { $_->{$b} <=> $_->{$a} } keys %$_ ]->[0] } @$table;
