#!/usr/bin/env raku

my regex vowels { :i <[aeiou]> }

sub reverse-vowels ($s) {
    $s
    andthen .comb: /<vowels>/
    andthen .reverse
    andthen $s, |.pairs
    andthen .reduce: -> $s, $ch { $s.subst: /<vowels>/, $ch.value, :ii, nth => $ch.key + 1 }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is reverse-vowels('Raku'),'Ruka';
    is reverse-vowels('Uiua'),'Auiu';
    is reverse-vowels('Perl'),'Perl';
    is reverse-vowels('Julia'),'Jaliu';
    done-testing;
}

multi MAIN ($s) {
    say reverse-vowels $s
}
