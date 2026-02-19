#!/bin/env raku

unit sub MAIN(UInt:D $int is copy where * ≤ 100);

my @fib = 1, 2, * + * ...^ * > 100;

my @answer;
my $ndx = @fib.first(* ≤ $int, :k, :end);

loop {
    @answer.push(@fib[$ndx]);
    $int -= @answer.tail;
    last if $int ≤ 0;
    $ndx = @fib[^($ndx-1)].first(* ≤ $int, :k, :end);
}

put @answer.join(',');
