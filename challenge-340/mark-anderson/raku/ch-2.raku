#!/usr/bin/env raku
use Test;

ok  ascending-numbers("The cat has 3 kittens 7 toys 10 beds");
nok ascending-numbers("Alice bought 5 apples 2 oranges 9 bananas");
ok  ascending-numbers("I ran 1 mile 2 days 3 weeks 4 months");
nok ascending-numbers("Bob has 10 cars 10 bikes");
ok  ascending-numbers("Zero is 0 one is 1 two is 2");

sub ascending-numbers($s)
{
    [<] $s.comb(/ <digit>+ /)
}
