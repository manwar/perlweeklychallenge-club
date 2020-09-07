#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/

# Comments: https://andrewshitov.com/2020/09/07/add-up-fibonacci-numbers-the-weekly-challenge-77-task-1/

my $n = @*ARGS[0] // 42;
my @fib = 1, 2, * + * ...^ * > $n;

"$_.join(' + ') = $n".put for @fib.combinations.grep(*.sum == $n);
