#!/usr/bin/env perl

# Challenge 025
#
# Generate a longest sequence of the following “English Pokemon” names where
# each name starts with the last letter of previous name.

use strict;
use warnings;
use 5.030;

my @names = qw( audino bagon baltoy banette bidoof braviary bronzor carracosta
                charmeleon cresselia croagunk darmanitan deino emboar emolga
                exeggcute gabite girafarig gulpin haxorus heatmor heatran
                ivysaur jellicent jumpluff kangaskhan kricketune landorus
                ledyba loudred lumineon lunatone machamp magnezone mamoswine
                nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
                porygon2 porygonz registeel relicanth remoraid rufflet sableye
                scolipede scrafty seaking sealeo silcoon simisear snivy snorlax
                spoink starly tirtouga trapinch treecko tyrogue vigoroth
                vulpix wailord wartortle whismur wingull yamask
            );

say join(" ", find_longest_sequence(@names));

sub find_longest_sequence1 {
    my($longest_path, $current_path, $seen) = @_;

    # words that can still be used
    my @pending = grep {!$seen->{$_} &&
                        (@$current_path == 0 ||
                         substr($current_path->[-1], -1, 1) eq substr($_, 0, 1))
                       } @names;
    if (@pending == 0) {                    # end of search
        if (@$current_path > @$longest_path) {
            @$longest_path = @$current_path;
        }
    }
    else {                                  # find each possible path
        for my $word (@pending) {
            find_longest_sequence1($longest_path,
                                   [ @$current_path, $word ],
                                   { %$seen, $word => 1 } );
        }
    }
}

sub find_longest_sequence {
    my(@words) = @_;
    my @longest_path;
    find_longest_sequence1(\@longest_path, [], {});
    return @longest_path;
}
