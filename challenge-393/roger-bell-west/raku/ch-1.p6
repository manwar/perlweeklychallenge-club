#! /usr/bin/raku

use Test;

plan 5;

is(pythagorasmultiplied(20), 12, 'example 1');
is(pythagorasmultiplied(7), 2, 'example 2');
is(pythagorasmultiplied(1), 0, 'example 3');
is(pythagorasmultiplied(15), 8, 'example 4');
is(pythagorasmultiplied(30), 22, 'example 5');

sub pythagorasmultiplied($n) {
    my %squared;
    my $ct = 0;
    for 5 .. $n -> $c {
        %squared{$c} ||= $c * $c;
        for 1 .. $c - 2 -> $a {
            %squared{$a} ||= $a * $a;
            for $a + 1 .. $c - 1 -> $b {
                %squared{$b} ||= $b * $b;
                my $tot = %squared{$a} + %squared{$b};
                if ($tot > %squared{$c}) {
                    last;
                }
                if ($tot == %squared{$c}) {
                    $ct += 1;
                }
            }
        }
    }
    $ct * 2;
}
