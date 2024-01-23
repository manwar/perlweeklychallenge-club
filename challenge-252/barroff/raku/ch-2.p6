#!/usr/bin/env raku

use v6.d;

# multi sub unique-sum-zero(0) {
#     return ()
# }

multi sub unique-sum-zero(Int:D $n where $n >= 0 --> Seq) {
    my @ints;
    map({ @ints.append($_); @ints.append(-$_) }, 1..Int($n / 2));
    @ints.append(0) if $n % 2 == 1;
    return sort(@ints);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is unique-sum-zero(5), (-2, -1, 0, 1, 2), 'works for 5';
    is unique-sum-zero(3), (-1, 0, 1), 'works for 3';
    is unique-sum-zero(1), (0), 'works for 1';
    is unique-sum-zero(0), (), 'works for 0';
}

#| Take user provided list like 1 2 10
multi sub MAIN(Int:D $n) {
    say unique-sum-zero($n);
}
