#! /usr/bin/raku

use Test;

plan 5;

is(ascendingnumbers('The cat has 3 kittens 7 toys 10 beds'), True, 'example 1');
is(ascendingnumbers('Alice bought 5 apples 2 oranges 9 bananas'), False, 'example 2');
is(ascendingnumbers('I ran 1 mile 2 days 3 weeks 4 months'), True, 'example 3');
is(ascendingnumbers('Bob has 10 cars 10 bikes'), False, 'example 4');
is(ascendingnumbers('Zero is 0 one is 1 two is 2'), True, 'example 5');

sub ascendingnumbers($a) {
    my $prev = Nil;
    for $a.split(' ') -> $c {
        if ($c ~~ /^<[0..9]>+$/) {
            with $prev {
                if ($prev >= $c) {
                    return False;
                }
            }
            $prev = $c;
        }
    }
    True;
}
