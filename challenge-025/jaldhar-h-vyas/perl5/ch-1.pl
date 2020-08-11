#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub graph {
    my ($words) = @_;
    my %graph;

    for my $word (@{$words}) {
        my $lastLetter = substr $word, -1, 1;
        for my $other (@{$words}) {
            if ((substr $other, 0, 1) eq $lastLetter && $other ne $word) {
                push @{$graph{$word}}, $other;
            }
        }
    }

    return \%graph;
}

sub traverse {
    my ($graph, $word, $path) = @_;

    my $path_copy = [ @{$path} ];
    push @{$path_copy}, $word;

    my $longest = $path_copy;
    for my $neighbor (@{$graph->{$word}}) {
        if (!grep /$neighbor/,  @{$path_copy}) {
            my $p = traverse($graph, $neighbor, $path_copy);
            if (scalar @{$p} > @{$longest}) {
                $longest = $p;
            }
        }
    }

    return $longest;
}

my @words = qw/
    audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon
    cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig
    gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan
    kricketune landorus ledyba loudred lumineon lunatone machamp magnezone
    mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
    porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede
    scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga
    trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull
    yamask
/;

my $g = graph(\@words);
my $longest = [];

for my $word (keys %{$g}) {
    my $path = traverse($g, $word, []);
    if (scalar @{$path} > scalar @{$longest}) {
        $longest = $path;
    }
}

say join q{ }, @{$longest};
