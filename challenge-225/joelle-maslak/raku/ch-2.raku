#!/usr/bin/env raku
use v6.d;

my @INPUT = (10, 4, 8, 3);

sub leftsum(@numbers) {
    return () unless @numbers.elems;
    gather {
        for 0..^(@numbers.elems) -> $i {
            take @numbers[0..^$i].sum;
        }
    }
}

sub MAIN(*@input) {
    @input = @INPUT unless @input.elems;

    my @left = leftsum(@input);
    my @right = leftsum(@input.reverse).reverse;

    my @differences = (@left Z @right).map: {abs($^a[0] - $^a[1])};
    say "Left/right sum differences: " ~ @differences.join(", ");
}


