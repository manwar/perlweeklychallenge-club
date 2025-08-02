#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(reverseletters('p-er?l'), 'l-re?p', 'example 1');
is(reverseletters('wee-k!L-y'), 'yLk-e!e-w', 'example 2');
is(reverseletters('_c-!h_all-en!g_e'), '_e-!g_nel-la!h_c', 'example 3');

sub reverseletters($a) {
    my @vout = (' ') x length($a);
    my @letterslots;
    my @letters;
    my @as =  split '', $a;
    while (my ($i, $c) = each @as) {
        if ($c =~ /[A-Za-z]/) {
            push @letterslots, $i;
            push @letters, $c;
        } else {
            $vout[$i] = $c;
        }
    }
    foreach my $i (@letterslots) {
        $vout[$i] = pop @letters;
    }
    join('', @vout);
}
