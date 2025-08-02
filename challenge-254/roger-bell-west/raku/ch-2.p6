#! /usr/bin/raku

use Test;

plan 4;

is(reversevowels('Raku'), 'Ruka', 'example 1');
is(reversevowels('Perl'), 'Perl', 'example 2');
is(reversevowels('Julia'), 'Jaliu', 'example 3');
is(reversevowels('Uiua'), 'Auiu', 'example 4');

sub is_vowel($c) {
    if ($c ~~ m:i/<[aeiou]>/) {
        return True;
    } else {
        return False;
    }
}

sub reversevowels($a) {
    my @p = $a.comb();
    my @q = @p.grep({is_vowel($_)});
    my $qi = @q.elems;
    my @o;
    for @p -> $c {
        if (is_vowel($c)) {
            $qi--;
            my $nc = @q[$qi];
            if ($c eq uc($c)) {
                $nc = uc($nc);
            } else {
                $nc = lc($nc);
            }
            @o.push($nc);
        } else {
            @o.push($c);
        }
    }
    return @o.join('');
}
