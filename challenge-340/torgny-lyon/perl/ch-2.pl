#!/usr/bin/perl

use v5.42;

use Test::More tests => 5;

use List::Util qw(all);

sub is_ascending {
    my @numbers = $_[0] =~ /\d+/g;
    all { $numbers[$_] < $numbers[$_ + 1] } 0..($#numbers -1);
}

ok(    is_ascending('The cat has 3 kittens 7 toys 10 beds'));
ok(not is_ascending('Alice bought 5 apples 2 oranges 9 bananas'));
ok(    is_ascending('I ran 1 mile 2 days 3 weeks 4 months'));
ok(not is_ascending('Bob has 10 cars 10 bikes'));
ok(    is_ascending('Zero is 0 one is 1 two is 2'));
