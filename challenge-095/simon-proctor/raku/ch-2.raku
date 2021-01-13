#!/usr/bin/env raku

use v6;

role Stack {
    has @!list handles <push pop min>;

    method top { @!list[*-1]; }
}

sub MAIN() {
    my $stack = Stack.new;
    $stack.push(2);
    $stack.push(-1);
    $stack.push(0);
    say $stack.pop; # print and removes 0
    say $stack.top; # prints -1
    $stack.push(0);
    say $stack.min; # prints -1
}
