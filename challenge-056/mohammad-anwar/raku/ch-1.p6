#!/usr/bin/env perl6

use v6.d;

multi sub MAIN(*@) is hidden-from-USAGE {
    say $*USAGE;
    say "\nERROR: Invalid k, must be > 0 !!!";
}

multi sub MAIN(Int :$K where * > 0 = 3, Int :$S = 10) {

    my Int @L = (1..50).pick($S).sort.reverse;
    say "\@L = [" ~ @L.join(", ") ~ "]";
    my $matched = find-match($K, @L);

    (@$matched.elems > 0)
    ??
    (@$matched.join("\n").say)
    !!
    (say "Oops, none matched.");
}

sub find-match(Int $K, @L where .all ~~ Int) {
    my $matched = [];
    my $S = @L.elems;
    my $fmt = "%2s,%2s => (%2s - %2s) => %d";
    for 0 .. --$S -> $i {
        for $i+1 .. $S -> $j {
            my $k = @L[$i] - @L[$j];
            if $k == $K {
                $matched.push: sprintf($fmt, $i, $j, @L[$i], @L[$j], $k);
            }
        }
    }

    return $matched;
}
