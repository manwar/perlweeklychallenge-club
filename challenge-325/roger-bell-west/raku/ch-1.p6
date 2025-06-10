#! /usr/bin/raku

use Test;

plan 3;

is(consecutiveone([0, 1, 1, 0, 1, 1, 1]), 3, 'example 1');
is(consecutiveone([0, 0, 0, 0]), 0, 'example 2');
is(consecutiveone([1, 0, 1, 0, 1, 1]), 2, 'example 3');

sub consecutiveone(@a) {
    my %h;
    %h{0} = 0;
    my $latch = 0;
    my $latched = False;
    for @a.kv -> $i, $n {
        if ($n == 1 && !$latched) {
            $latched = True;
            $latch = $i;
        }
        if ($n == 0 && $latched) {
            $latched = False;
            %h{$latch} = $i - $latch;
        }
    }
    if ($latched) {
        %h{$latch} = @a.elems - $latch;
    }
    %h.values().max();
}
