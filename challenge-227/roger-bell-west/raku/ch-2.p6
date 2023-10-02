#! /usr/bin/raku

use Test;

plan 21;

is(roman2int('I'), 1, 'example 1');
is(roman2int('II'), 2, 'example 2');
is(roman2int('IV'), 4, 'example 3');
is(roman2int('IX'), 9, 'example 4');
is(roman2int('XXX'), 30, 'example 5');
is(roman2int('MDCLXVI'), 1666, 'example 6');
is(int2roman(1), 'I', 'example 7');
is(int2roman(2), 'II', 'example 8');
is(int2roman(4), 'IV', 'example 9');
is(int2roman(9), 'IX', 'example 10');
is(int2roman(30), 'XXX', 'example 11');
is(int2roman(1666), 'MDCLXVI', 'example 12');
is(romanmaths('IV + V'), 'IX', 'example 13');
is(romanmaths('M - I'), 'CMXCIX', 'example 14');
is(romanmaths('X / II'), 'V', 'example 15');
is(romanmaths('XI * VI'), 'LXVI', 'example 16');
is(romanmaths('VII ** III'), 'CCCXLIII', 'example 17');
is(romanmaths('V - V'), 'nulla', 'example 18');
is(romanmaths('V / II'), 'non potest', 'example 19');
is(romanmaths('MMM + M'), 'non potest', 'example 20');
is(romanmaths('V - X'), 'non potest', 'example 21');

sub roman2int($roman) {
    if ($roman eq '') {
        return 0;
    }
    for (
        [ 'M', 1000 ],
        [ 'CM', 900 ],
        [ 'D', 500 ],
        [ 'CD', 400 ],
        [ 'C', 100 ],
        [ 'XC', 90 ],
        [ 'L', 50 ],
        [ 'XL', 40 ],
        [ 'X', 10 ],
        [ 'IX', 9 ],
        [ 'V', 5 ],
        [ 'IV', 4 ],
        [ 'I', 1 ],
    ) -> @s {
        with $roman.index(@s[0]) -> $ix {
            if ($ix == 0) {
                return @s[1] + roman2int(substr($roman, @s[0].chars));
            }
        }
    }
    return 0;
}

sub int2roman($n0) {
    my $number = $n0;
    my $mn = "";
    for (
        [ 'M', 1000 ],
        [ 'CM', 900 ],
        [ 'D', 500 ],
        [ 'CD', 400 ],
        [ 'C', 100 ],
        [ 'XC', 90 ],
        [ 'L', 50 ],
        [ 'XL', 40 ],
        [ 'X', 10 ],
        [ 'IX', 9 ],
        [ 'V', 5 ],
        [ 'IV', 4 ],
        [ 'I', 1 ],
    ) -> @s {
        while (@s[1] <= $number) {
            $mn ~= @s[0];
            $number -= @s[1];
        }
    }
    return $mn;
}

sub romanmaths($ax) {
    my @elems = $ax.split(' ');
    my $a = roman2int(@elems[0]);
    my $b = roman2int(@elems[2]);
    my $c = -1;
    if (@elems[1] eq '+') {
        $c = $a + $b;
    } elsif (@elems[1] eq '-') {
        $c = $a - $b;
    } elsif (@elems[1] eq '*') {
        $c = $a * $b;
    } elsif (@elems[1] eq '/') {
        if ($a % $b == 0) {
            $c = $a div $b;
        }
    } elsif (@elems[1] eq '**') {
        $c = $a ** $b;
    }
    if ($c > 3999 || $c < 0) {
        return 'non potest';
    } elsif ($c == 0) {
        return 'nulla';
    } else {
        return int2roman($c);
    }
}
