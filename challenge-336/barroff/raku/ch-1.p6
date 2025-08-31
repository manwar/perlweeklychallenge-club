#!/usr/bin/env raku

use v6.d;

sub equal-group(@ints --> Bool) {
    my $groups = @ints.Bag;
    my Int $mg = $groups.values.min;
    return False if $mg == 1;
    so all($groups.values.map({ $_ mod $mg })) == 0;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is equal-group([1,1,2,2,2,2]), True, 'works for [1,1,2,2,2,2]';
    is equal-group([1,1,1,2,2,2,3,3]), False, 'works for [1,1,1,2,2,2,3,3]';
    is equal-group([5,5,5,5,5,5,7,7,7,7,7,7]), True,
        'works for [5,5,5,5,5,5,7,7,7,7,7,7]';
    is equal-group([1,2,3,4]), False, 'works for [1,2,3,4]';
    is equal-group([8,8,9,9,10,10,11,11]), True, 'works for [8,8,9,9,10,10,11,11]';
}

#| Take user provided numbers like 8,8,9,9,10,10,11,11
multi sub MAIN(*@ints) {
    say equal-group(@ints);
}
