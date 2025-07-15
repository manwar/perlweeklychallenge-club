#!/usr/bin/raku

sub newChar($left, $right) {
    my $char = $left;

    while $char eq $left || $char eq $right {
        $char = ('a' .. 'z').pick;
    }

    return "$left$char$right";
 }

sub MAIN(
    $str
) {
    $str.subst(/(.) \? (.)/, { newChar($0, $1) }, :g ).say;
}