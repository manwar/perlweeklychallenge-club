#!/usr/bin/env raku
use Test;

is reverse-vowels("Raku"),                               "Ruka";
is reverse-vowels("Perl"),                               "Perl";
is reverse-vowels("Julia"),                              "Jaliu";
is reverse-vowels("Uiua"),                               "Auiu";
is reverse-vowels("Supercalifragilisticexpialidocious"), "Suporcilofrigalistecixpiiladicaeus";

sub reverse-vowels($w)
{
    my @a = $w.comb;
    my @i = @a.grep(/:i<[aeiou]>/, :k);
    @a[@i] .= reverse;
    tclc [~] @a
}
