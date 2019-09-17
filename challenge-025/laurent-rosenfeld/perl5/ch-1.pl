#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my @names = qw /audino bagon baltoy banette bidoof braviary bronzor
                carracosta charmeleon cresselia croagunk darmanitan
                deino emboar emolga exeggcute gabite girafarig
                gulpin haxorus heatmor heatran ivysaur jellicent
                jumpluff kangaskhan kricketune landorus ledyba
                loudred lumineon lunatone machamp magnezone
                mamoswine nosepass petilil pidgeotto pikachu pinsir
                poliwrath poochyena porygon2 porygonz registeel
                relicanth remoraid rufflet sableye scolipede scrafty
                seaking sealeo silcoon simisear snivy snorlax spoink
                starly tirtouga trapinch treecko tyrogue vigoroth
                vulpix wailord wartortle whismur wingull yamask/;

my %name_by_letter;
for my $name (@names) {
    my $start_letter = substr $name, 0, 1;
    push @{$name_by_letter{$start_letter}}, $name;
}

my @best_seq;
my $best_count = 0;
for my $name (@names) {
    search_seq( [$name], {$name => 1} );
}
say "BEST SEQUENCES: ";
for my $item (@best_seq) {
   say "@$item";
}
say "Number of sequences: ", scalar @best_seq;

sub search_seq {
    my ($current_seq, $seen) = @_;
    my $last_name = $current_seq->[-1];
    my $last_letter = substr $last_name, -1, 1;
    my @next_candidates = grep { not exists $seen->{$_} }
        @{$name_by_letter{$last_letter}};
    if (scalar @next_candidates == 0) {
        my $count = scalar @$current_seq;
        if ($count > $best_count) {
            @best_seq = ($current_seq);
            $best_count = $count;
        } elsif ($count == $best_count) {
            push @best_seq, $current_seq;
        }
    } else {
        for my $name (@next_candidates) {
            my %local_seen = %$seen;
            $local_seen{$name} = 1;
            search_seq ([@$current_seq, $name], {%local_seen});
        }
    }
}
