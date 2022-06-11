#!#!/usr/bin/env raku
use experimental :cached;
proto rob-the-house (+@) is cached {*};
multi rob-the-house (+@ where Empty) {0}
multi rob-the-house (+@ ($a)) {$a}
multi rob-the-house(+@ ($h, **@t ($,**@tt))) {
    rob-the-house(@t) max  ($h+rob-the-house(@tt))
}

multi MAIN (Bool :test($)!) {
    use Test;
    is rob-the-house(), 0;
    is rob-the-house(3),3;
    is rob-the-house(2, 4, 5), 7;
    is rob-the-house(4, 2, 3, 6, 5, 3), 13;
    done-testing;
}

multi MAIN (*@a) {
    say rob-the-house @a;
}
