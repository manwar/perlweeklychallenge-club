#!/bin/env raku

unit sub MAIN(*@ints);

@ints = +«@ints;
my $side-len = @ints.sum div 4;
terminate(False) unless $side-len * 4 == @ints.sum;

for 1..3 {
    my @sides = @ints.combinations.grep(*.sum == $side-len).first;
    terminate(False) without @sides[0];
    @ints = bag-to-array(@ints.Bag (-) @sides.Bag);
}
terminate(True);

sub bag-to-array(%b --> Array:D) {
    %b.keys.map({ |($_ xx %b{$_}) }).Array
}

sub terminate(Bool:D $ok) {
    put $ok ?? 'true' !! 'false';
    exit;
}
