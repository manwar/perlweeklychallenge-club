#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;

# Generate a longest sequence of the following “English Pokemon” names
# where each name starts with the last letter of previous name.

my @names = qw/
    audino bagon baltoy banette bidoof braviary bronzor carracosta
    charmeleon cresselia croagunk darmanitan deino emboar emolga
    exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur
    jellicent jumpluff kangaskhan kricketune landorus ledyba loudred
    lumineon lunatone machamp magnezone mamoswine nosepass petilil
    pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz
    registeel relicanth remoraid rufflet sableye scolipede scrafty
    seaking sealeo silcoon simisear snivy snorlax spoink starly
    tirtouga trapinch treecko tyrogue vigoroth vulpix wailord
    wartortle whismur wingull yamask
/;

my $longest = [];

try([], "", @names);

say "@$longest";

# naive brute force recursion
sub try {
    my ($picks, $prefix, @rest) = @_;

    $longest = $picks if @$picks > @$longest;

    for (my $i = 0; $i < @rest; ++$i) {
        next unless $rest[$i] =~ /^$prefix/;
        try([@$picks, $rest[$i]],
            substr($rest[$i], -1),
            @rest[0..$i-1, $i+1..$#rest]);
    }
}
