#!/usr/bin/env raku

sub equal-pairs(@nums --> List) {
    my %number-bag = Bag(@nums);
    return () if so any(%number-bag.values()) % 2 ≠ 0;
    my @pairs = map({ Slip(($_, $_) xx (%number-bag{$_} div 2))}, %number-bag.keys);
    return @pairs;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is sort(equal-pairs([3, 2, 3, 2, 2, 2])), ((2, 2), (2, 2), (3, 3)), 'Works for (3, 2, 3, 2, 2, 2)';
    is equal-pairs([1, 2, 3, 4]), (), 'Works for (1, 2, 3, 4)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints) {
    say equal-pairs(@ints);
}
