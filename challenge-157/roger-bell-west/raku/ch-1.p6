#! /usr/bin/perl6

use Test;

plan 3;

is-deeply(pythagoreanmeans([1,3,5,7,9]),
          {AM => 5.0, GM => 3.9, HM => 2.8},
          'example 1');

is-deeply(pythagoreanmeans([2,4,6,8,10]),
          {AM => 6.0, GM => 5.2, HM => 4.4},
          'example 2');

is-deeply(pythagoreanmeans([1,2,3,4,5]),
          {AM => 3.0, GM => 2.6, HM => 2.2},
          'example 3');

sub pythagoreanmeans(@s) {
    return {
        AM => round(arithmeticmean(@s),0.1),
        GM => round(geometricmean(@s),0.1),
        HM => round(harmonicmean(@s),0.1),
    };
}

sub arithmeticmean(@s) {
    return @s.reduce(&infix:<+>)/@s.elems;
}

sub geometricmean(@s) {
    return @s.reduce(&infix:<*>) ** (1/@s.elems);
}

sub harmonicmean(@s) {
    return @s.elems / @s.map({1/$_}).reduce(&infix:<+>);
}
