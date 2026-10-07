#! /usr/bin/raku

use Test;

plan 5;

is(alternatecase('aAbB'), 0, 'example 1');
is(alternatecase('AAbb'), 1, 'example 2');
is(alternatecase('AAAbbb'), 3, 'example 3');
is(alternatecase('aABb'), 1, 'example 4');
is(alternatecase('bBBAaa'), 2, 'example 5');

sub alternatecase($a) {
    my @uppers = $a.comb.map({if ($_ ~~ /<[A..Z]>/) { True } else { False }});
    my @queue;
    push @queue,{ct => 0, up => @uppers};
    while (@queue.elems > 0) {
        my %ctup = @queue.shift();
        my $ct = %ctup{"ct"};
        my @up = %ctup{"up"}.flat;
        my @swaps;
        for 0 .. @up.elems - 2 -> $i {
            if (@up[$i] == @up[$i + 1]) {
                if ($i > 0) {
                    @swaps.push($i - 1);
                }
                if ($i < @up.elems - 2) {
                    @swaps.push($i + 1);
                }
            }
        }
        if (@swaps.elems == 0) {
            return $ct;
        }
        for @swaps -> $sw {
            my @uq = @up.clone();
            (@uq[$sw], @uq[$sw + 1]) = (@uq[$sw + 1], @uq[$sw]);
            @queue.push({ct => $ct + 1, up => @uq});
        }
    }
    0;
}
