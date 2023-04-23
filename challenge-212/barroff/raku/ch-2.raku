#!/usr/bin/env raku

use v6.d;

sub get-smallest-key(BagHash $bh --> Int) {
    $bh.keys.min;
}

sub rearrange-groups(Int @numbers, Int $size) {
    return -1 if @numbers.elems % $size ≠ 0;
    my $remains = BagHash(@numbers);
    my (Int $first-element, Range $range);
    my @groups = gather {
        while $remains {
            $first-element = get-smallest-key($remains);
            $range = $first-element .. $first-element + $size - 1;
            0 < map({ $remains{$_} }, $range.List).all
                ?? take $range.List
                !! return -1;
            map({ $remains{$_}-- }, $range.List);
        }
    }
    return @groups;
}


#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is rearrange-groups(Array[Int].new(1,2,3,5,1,2,7,6,3), 3),
        ((1,2,3), (1,2,3), (5,6,7)), 'Works for (1,2,3,5,1,2,7,6,3)';
    is rearrange-groups(Array[Int].new(1,2,3), 2), -1, 'Works for (1,2,3)';
    is rearrange-groups(Array[Int].new(1,2,4,3,5,3), 3),
        ((1,2,3), (3,4,5)), 'Works for (1,2,4,3,5,3)';
    is rearrange-groups(Array[Int].new(1,5,2,6,4,7), 3),
        -1, 'Works for (1,5,2,6,4,7)';
}
