#!/usr/bin/env raku

sub group-hero(@nums --> Int) {
    sum(map({ (max($_) ** 2) * min($_) }, combinations(@nums)[1..*-1]))
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 1;

    is group-hero(( 2, 1, 4 )), 141, 'Works for (2, 1, 4)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(Int @ints) {
    my Int @nums = @ints;
    say group-hero(@nums);
}
