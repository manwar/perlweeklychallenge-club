#!/usr/bin/env perl6
use v6;

my @words=<audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask>;

sub lgchain(@acc,$word,@words) {
    my @fewer-words=(@words (-) $word).keys.grep({ $_.starts-with($word.comb.[*-1]) });
    @fewer-words == 0 && return ($word,|@acc);    
    return @fewer-words.map({ lgchain(@acc,$_,@fewer-words) }).max({ $_.elems }).map({ $word, |$_ });
}

say @words.map({ lgchain([],$_,@words) }).map(|*).max(*.elems);
