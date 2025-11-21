#!/usr/bin/env raku

use Test;

my @examples = (
    { in => "textbook",     exp => 0 },
    { in => "book",         exp => 1 },
    { in => "AbCdEfGh",     exp => 1 },
    { in => "rhythmmyth",   exp => 0 },
    { in => "UmpireeAudio", exp => 0 },
);

is(string-alike($_<in>), $_<exp>) for @examples;

done-testing;

sub string-alike(Str $s) {
    my $l = $s.chars div 2;
    my $v = $s.substr(0, $l).comb.grep({ /<[aeiouAEIOU]>/ }).elems;
    return ($v > 0 && $v == $s.substr($l).comb.grep({ /<[aeiouAEIOU]>/ }).elems) ?? 1 !! 0;
}
