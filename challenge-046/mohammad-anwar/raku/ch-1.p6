#!/usr/bin/env perl6

use v6.d;

sub MAIN() {

    my @messages = (
        'P + 2 l ! a t o',
        '1 e 8 0 R $ 4 u',
        '5 - r ] + a > /',
        'P x w l b 3 k \\',
        '2 e 3 5 R 8 y u',
        '< ! r ^ ( ) k 0'
    );

    my $table = [];
    for @messages -> $message {
        my $column = 0;
        for $message.split(" ") -> $char {
            $table.[$column++].{$char}++;
        }
    }

    my $message;
    for 0..$table.elems -> $i {
        for $table.[$i] -> $row {
            $message ~= $row.sort(*.values).reverse.[0].keys;
        }
    }

    say $message;
}
