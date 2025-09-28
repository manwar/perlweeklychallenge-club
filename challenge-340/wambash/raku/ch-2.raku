#!/usr/bin/env raku

sub ascending-numbers ($str) {
    [<] $str.comb: /\d+/
}

multi MAIN (Bool :test($)!) {
    use Test;
    is ascending-numbers('The cat has 3 kittens 7 toys 10 beds'), True;
    is ascending-numbers('Alice bought 5 apples 2 oranges 9 bananas'), False;
    is ascending-numbers('I ran 1 mile 2 days 3 weeks 4 months'), True;
    is ascending-numbers('Bob has 10 cars 10 bikes'), False;
    is ascending-numbers('Zero is 0 one is 1 two is 2'), True;
    done-testing;
}

multi MAIN ($str) {
    say ascending-numbers $str;
}
