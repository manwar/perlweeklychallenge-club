#!/usr/bin/perl6
use experimental :cached;

sub graph (*@words) {
    my Array %graph;


    for @words -> $word {
        my $lastLetter = $word.substr(*-1, 1);
        for @words.grep(none /$word/) -> $other {
            if $other.substr(0, 1) eq $lastLetter {
                %graph{$word}.push($other);
            }
        }
    }

    return %graph;
}

sub traverse(Array %graph, $word, @path is copy) {
    @path.push($word);

    my @longest = @path;
    for %graph{$word}.Array -> $neighbor {
        if @path.grep(none /$neighbor/) {
            my @p = traverse(%graph, $neighbor, @path);
            if @p.elems > @longest.elems {
                @longest = @p;
            }
        }
    }

    return @longest;
}

sub MAIN() {
    my @words = <
        audino bagon baltoy banette bidoof braviary bronzor carracosta
        charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute
        gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent
        jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone
        machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir
        poliwrath poochyena porygon2 porygonz registeel relicanth remoraid
        rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy
        snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix
        wailord wartortle whismur wingull yamask
    >;

    my Array %g = graph(@words);

    my @longest;
    for %g.keys -> $word {
        my @path = traverse(%g, $word, []);
        if (@path.elems > @longest.elems) {
            @longest = @path;
        }
    }

    @longest.join(q{ }).say;
}