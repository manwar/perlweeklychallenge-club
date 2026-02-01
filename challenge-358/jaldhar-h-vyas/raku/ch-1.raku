#!/usr/bin/raku

sub MAIN(
    *@strings
) {
    my %vals;

    for @strings -> $str {
        %vals{$str} = $str.match(/^ <(\d+)> $/) ?? $str.Int !! $str.chars;
    }

    %vals.values.sort({$^a <=> $^b}).tail.say;
}
