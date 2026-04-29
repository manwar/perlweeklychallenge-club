#! /usr/bin/raku

use Test;

plan 5;

is(missingletter('a c ? g i'), 'e', 'example 1');
is(missingletter('a d ? j m'), 'g', 'example 2');
is(missingletter('a e ? m q'), 'i', 'example 3');
is(missingletter('a c f ? k'), 'h', 'example 4');
is(missingletter('b e g ? l'), 'j', 'example 5');

sub missingletter($a) {
    my @c = $a.split(" ").grep({$_ ne ""}).map({$_.ord});
    my @d;
    for @c.rotor(2 => -1) -> @i {
        if (@i[0] == 63 || @i[1] == 63) {
            @d.push(0);
        } else {
            @d.push(@i[1] - @i[0]);
        }
    }
    for @d.kv -> $n, $delta {
        if ($delta == 0) {
            my $ch;
            if ($n < 2) {
                $ch = @c[$n + 2] - @d[$n + 2];
            } else {
                $ch = @c[$n] + @d[$n - 2];
            }
            return $ch.chr;
        }
    }
    "";
}
