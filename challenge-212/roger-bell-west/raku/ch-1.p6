#! /usr/bin/raku

use Test;

plan 2;

is(jumpingletters('Perl', [2, 22, 19, 9]), 'Raku', 'example 1');
is(jumpingletters('Raku', [24, 4, 7, 17]), 'Perl', 'example 2');

sub jumpingletters($word, @jump) {
    my @s = '';
    my $i = 0;
    for $word.comb -> $c {
        my $d = ord($c) + @jump[$i] % 26;
        if (($c le 'Z' && $d > 90) || $d > 122) {
            $d -= 26;
        }
        @s.push(chr($d));
        $i++;
    }
    return join('', @s);
}
