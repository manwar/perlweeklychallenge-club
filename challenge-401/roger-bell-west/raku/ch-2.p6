#! /usr/bin/raku

sub reconstructdigits($a) {
    my @digits = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
    my @cc;
    for 0 .. 9 -> $d {
        @cc.push(Bag(@digits[$d].comb));
    }
    my %cs = BagHash($a.comb);
    my @ol;
    for [2, 6, 0, 7, 4, 3, 5, 8, 1, 9] -> $d {
        while (@cc[$d] (<=) %cs) {
            @ol.push($d);
            %cs = %cs (-) @cc[$d];
        }
    }
    @ol = @ol.sort({$^a <=> $^b});
    @ol.join('');
}

use Test;

plan 5;

is(reconstructdigits('zroezerotwowtwotwo'), '00222', 'example 1');
is(reconstructdigits('esveeneinght'), '78', 'example 2');
is(reconstructdigits('oneenineeninefive'), '1599', 'example 3');
is(reconstructdigits('zeroonetwothreeeightfivesixsevenninefour'), '0123456789', 'example 4');
is(reconstructdigits('ninenineninenine'), '9999', 'example 5');
