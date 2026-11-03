#!/usr/bin/raku

sub MAIN(
    $year,
) {
    my @elements = < Metal Metal Water Water Wood Wood Fire Fire Earth Earth >;
    my @animals = < Monkey Rooster Dog Pig Rat Ox Tiger Rabbit Dragon Snake Horse Goat >;

    say @elements[$year % 10], ' ', @animals[$year % 12];
}
