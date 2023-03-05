#!/usr/bin/env raku

use v6.d;

constant $time-format = /
    $<hours>=(\d ** 2)
    ':'
    $<minutes>=(\d ** 2)
/;

sub convert-to-minutes(Str $time --> Int) {
    $time ~~ $time-format or
        die "Time string not in the right format.\nExpected 'HH:MM' but got $time";
    $<hours> × 60 + $<minutes>;
}

sub time-difference(Str $time1, Str $time2 --> Int) {
    constant $minutes-of-a-day = 24 × 60;
    my Int $minutes1 = convert-to-minutes($time1);
    my Int $minutes2 = convert-to-minutes($time2);
    my Int $time-diff = abs($minutes1 - $minutes2);
    $time-diff < $minutes-of-a-day ÷ 2 ?? $time-diff !! $minutes-of-a-day - $time-diff;
}

sub shortest-time(Str @times --> Int) {
    min(map({ time-difference(@_[0], @_[1]) }, @times.combinations(2)));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is shortest-time(Array[Str].new(["00:00", "23:55", "20:00"])), 5,
        'works for ("00:00", "23:55", "20:00")';
    is shortest-time(Array[Str].new(["01:01", "00:50", "00:57"])), 4,
        'works for ("01:01", "00:50", "00:57")';
    is shortest-time(Array[Str].new(["10:10", "09:30", "09:00", "09:55"])), 15,
        'works for ("10:10", "09:30", "09:00", "09:55")';
}

#| Take user provided list like 1 2 2 3
multi sub MAIN(*@elements where @elements.elems ≥ 2 && all(@elements) ~~ $time-format) {
    my Str @str-elements = @elements;
    say shortest-time(@str-elements);
}
