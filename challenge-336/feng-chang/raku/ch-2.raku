#!/bin/env raku

unit sub MAIN(*@scores);

my @stack;
for @scores {
    when Int { @stack.push: $_ };
    when 'C' { @stack.pop };
    when 'D' { @stack.push: @stack.tail * 2 };
    when '+' { @stack.push: @stack.tail(2).sum };
}
put @stack.sum;
