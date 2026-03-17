#!/bin/env raku

unit sub MAIN(Str:D $s);

my %numbers = <zero one two three four five six seven eight nine> Z=> 0..9;

my $detector = /:s $<word> = [\w+] '-' $<vowels> = [\w+] ['vowel'||'vowels'] 'and' $<consonants> = [\w+] ['consonant'||'consonants'] /;

with $s.match($detector) -> $m {
    my ($vowels, $consonants) = do with $m<word>.comb -> @s {
        +@s.grep(<a e i o u>.any), +@s.grep(<a e i o u>.none)
    };
    put so %numbers{$m<vowels>} == $vowels && %numbers{$m<consonants>} == $consonants;
}
