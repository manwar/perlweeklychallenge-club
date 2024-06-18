#! /usr/bin/raku

use Test;

plan 3;

is(goatlatin('I love Perl'), 'Imaa ovelmaaa erlPmaaaa', 'example 1');
is(goatlatin('Perl and Raku are friends'), 'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa', 'example 2');
is(goatlatin('The Weekly Challenge'), 'heTmaa eeklyWmaaa hallengeCmaaaa', 'example 3');

sub goatlatin($a) {
    my @out;
    my @w = $a.split(' ');
    for @w.kv -> $ix, $word {
        my @c = $word.comb;
        my $nw = $word;
        if (@c[0] !~~ m:i/<[aeiou]>/) {
            @c.push(@c.shift);
            $nw = @c.join('');
        }
        $nw ~= 'ma';
        $nw ~= 'a' x ($ix + 1);
        @out.push($nw);
    }
    return @out.join(' ');
}
