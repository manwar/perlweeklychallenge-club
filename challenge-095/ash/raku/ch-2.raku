#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/

# The taks is to demonstrate stack _operations_, not _imlementaion_.

class Stack {
    has @!stack;

    method push($n) { @!stack.push($n) }
    method pop { @!stack.pop }
    method top { @!stack[*-1] }
    method min { @!stack.min }

    method empty { !@!stack }
}

my $s = Stack.new;
# $s.stack; # is unreachable

for ^10 {
    my $n = 10.rand.Int;
    say "push($n)";
    $s.push($n);

    say "\ttop = {$s.top}, min = {$s.min}";
}

say "pop() = {$s.pop}" while !$s.empty;
