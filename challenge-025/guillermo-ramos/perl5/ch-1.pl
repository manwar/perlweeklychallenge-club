#!/usr/bin/env perl
#
# Generate a longest sequence of the following “English Pokemon” names where
# each name starts with the last letter of previous name.
#
# audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon
# cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig
# gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan
# kricketune landorus ledyba loudred lumineon lunatone machamp magnezone
# mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
# porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede
# scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga
# trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull
# yamask
################################################################################

use strict;
use warnings;

use Memoize;

my @POKEMON = qw<audino bagon baltoy banette bidoof braviary bronzor carracosta
    charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute
    gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff
    kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp
    magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath
    poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye
    scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink
    starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle
    whismur wingull yamask>;

memoize('longest_starting_from');
sub longest_starting_from {
    my ($first, @pokemon) = @_;
    my @candidates = grep { substr($_, 0, 1) eq $first } @pokemon;
    my @longest_path;
    foreach my $candidate (@candidates) {
        my @path = longest_starting_from(substr($candidate, -1),
                                         grep { $_ ne $candidate} @pokemon);
        @longest_path = ($candidate, @path) if @path+1 > @longest_path;
    }
    return @longest_path;
}

sub longest {
    my @list = @_;
    my @longest_path;
    foreach my $letter ('a' .. 'z') {
        print "Trying letter $letter...\n";
        my @path = longest_starting_from($letter, @list);
        @longest_path = @path if @path > @longest_path;
        print "Longest so far: @longest_path\n";
    }
    return @longest_path;
}

longest(@POKEMON);
