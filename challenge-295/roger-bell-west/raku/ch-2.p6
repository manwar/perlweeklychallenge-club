#! /usr/bin/raku

use Test;

plan 3;

is(jumpgame([2, 3, 1, 1, 4]), 2, 'example 1');
is(jumpgame([2, 3, 0, 4]), 2, 'example 2');
is(jumpgame([2, 0, 0, 4]), -1, 'example 3');

sub jumpgame(@a) {
    my $target = @a.end;
    my %here = SetHash.new;
    %here{0}++;
    my $moves = 0;
    loop {
        $moves++;
        my %there = SetHash.new;
        for %here.keys -> $n {
            for ($n + 1)..min($n + @a[$n], $target) -> $i {
                %there{$i}++;
            }
        }
        if (%there.elems == 0) {
            return -1
        }
        if (%there{$target}:exists) {
            return $moves;
        }
        %here = %there;
    }
}
