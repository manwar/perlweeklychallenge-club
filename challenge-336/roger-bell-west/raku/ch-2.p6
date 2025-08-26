#! /usr/bin/raku

use Test;

plan 5;

is(finalscore(['5', '2', 'C', 'D', '+']), 30, 'example 1');
is(finalscore(['5', '-2', '4', 'C', 'D', '9', '+', '+']), 27, 'example 2');
is(finalscore(['7', 'D', 'D', 'C', '+', '3']), 45, 'example 3');
is(finalscore(['-5', '-10', '+', 'D', 'C', '+']), -55, 'example 4');
is(finalscore(['3', '6', '+', 'D', 'C', '8', '+', 'D', '-2', 'C', '+']), 128, 'example 5');

sub finalscore(@a) {
    my @p;
    for @a -> $n {
        given $n {
            when "C" {
                @p.pop;
            }
            when "D" {
                @p.push(2 * @p[*-1]);
            }
            when "+" {
                @p.push(@p[*-2] + @p[*-1]);
            }
            default {
                @p.push(0 + $n);
            }
        }
    }
    @p.sum;
}
