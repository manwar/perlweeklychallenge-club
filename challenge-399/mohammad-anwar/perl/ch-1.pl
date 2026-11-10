#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => ["AAAAA",     2], out => 5 },
    { in => ["ABCDE",     4], out => 5 },
    { in => ["AAABBBBAA", 1], out => 5 },
    { in => ["ABACADA",   2], out => 5 },
    { in => ["BAAABAAAA", 1], out => 8 },
);

is character_replacement(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub character_replacement($str, $k) {
    my @s = split //, $str;
    my %c;
    my $l     = 0;
    my $max_f = 0;

    for my $r (0 .. $#s) {
        $max_f = ++$c{$s[$r]} > $max_f ? $c{$s[$r]} : $max_f;
        if (($r - $l + 1) - $max_f > $k) {
            $c{$s[$l++]}--;
        }
    }
    return @s - $l;
}
