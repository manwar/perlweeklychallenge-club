#!/usr/bin/raku

sub MAIN(
    Str $str
) {
    my $time = 0;
    my $current = 'a';

    for $str.comb -> $char {
        my $distance = ($char.ord - $current.ord).abs;
        $time += ($distance, 26 - $distance).min + 1;
        $current = $char;
    }

    say $time;
}