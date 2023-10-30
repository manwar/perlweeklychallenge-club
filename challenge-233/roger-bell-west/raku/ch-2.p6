#! /usr/bin/raku

use Test;

plan 3;

is-deeply(frequencysort([1, 1, 2, 2, 2, 3]), [3, 1, 1, 2, 2, 2], 'example 1');
is-deeply(frequencysort([2, 3, 1, 3, 2]), [1, 3, 3, 2, 2], 'example 2');
is-deeply(frequencysort([-1, 1, -6, 4, 5, -6, 1, 4, 1]), [5, -1, 4, 4, -6, -6, 1, 1, 1], 'example 3');

sub frequencysort(@al) {
    my %ct;
    for @al -> $x {
        %ct{$x}++;
    }
    my %rct;
    for %ct.kv -> $k, $v {
        %rct{$v} ||= [];
        %rct{$v}.push($k);
    }
    my @out;
    for %rct.keys.sort({$^a <=> $^b}) -> $k {
        for %rct{$k}.sort({$^b <=> $^a}) -> $v {
            @out.append($v+0 xx $k);
        }
    }
    return @out;
}
