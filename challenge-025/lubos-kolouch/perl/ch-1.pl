#!/usr/bin/perl

use strict;
use warnings;

my @names =
  qw(audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask);

my %used;
my @sequence;

foreach my $name (@names) {
    next if $used{$name};
    my $current   = $name;
    my @temp      = ($current);
    my %temp_used = %used;
    $temp_used{$current} = 1;

    while (1) {
        my $found = 0;
        foreach my $next (@names) {
            next if $temp_used{$next};
            if ( substr( $current, -1 ) eq substr( $next, 0, 1 ) ) {
                $current = $next;
                push( @temp, $current );
                $temp_used{$current} = 1;
                $found = 1;
                last;
            }
        }
        last unless $found;
    }

    if ( scalar(@temp) > scalar(@sequence) ) {
        @sequence = @temp;
    }

    %used = %temp_used;
}

print join( " -> ", @sequence ) . "\n";
