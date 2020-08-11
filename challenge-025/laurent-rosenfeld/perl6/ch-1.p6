use v6;

my @names = < audino bagon baltoy banette bidoof braviary bronzor
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
                vulpix wailord wartortle whismur wingull yamask >;

my %name-by-letter;
for @names -> $name {
    my $start-letter = substr $name, 0, 1;
    push %name-by-letter{$start-letter}, $name;
}

my @best-seq;
my $best-count = 0;
for @names -> $name {
    search-seq( [$name], $name.SetHash );
}
say "BEST SEQUENCES: ";
for @best-seq -> $item {
   say "$item";
}
say "Number of sequences: ", @best-seq.elems;
say now - INIT now;

sub search-seq (@current-seq, $seen) {
    my $last-name = @current-seq[*-1];
    my $last-letter = substr $last-name, *-1, 1;
    my @next-candidates = grep {defined $_}, # Remove empty slots
        (@(%name-by-letter{$last-letter}) (-) $seen).keys;
    if ( @next-candidates.elems == 0) {
        my $count = @current-seq.elems;
        if $count > $best-count {
            @best-seq = @current-seq;
            $best-count = $count;
        } elsif ($count == $best-count) {
            push @best-seq, @current-seq;
        }
    } else {
        for @next-candidates -> $name {
            my @new-seq = | @current-seq, $name;
            search-seq( @new-seq, $seen ∪ $name.SetHash );
        }
    }
}
