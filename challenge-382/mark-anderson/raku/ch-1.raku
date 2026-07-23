#!/usr/bin/env raku
use Test;

is-deeply hamiltonian-cycle(32), [1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5, 31, 18, 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15];

is-deeply hamiltonian-cycle(15), Empty;

is-deeply hamiltonian-cycle(34), [1, 3, 13, 12, 4, 32, 17, 8, 28, 21, 15, 34, 30, 19, 6, 10, 26, 23, 2, 14, 22, 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24];

sub hamiltonian-cycle($n)
{
    my @squares = squares($n);
    my %graph is Map = graph($n);
    my @seen = [1];
    my @stack = item [%graph{1}];

    loop
    {
        @seen.push: @stack.tail.shift;
        @stack.push: %graph{@seen.tail}.Array; 
        @stack.tail = (@stack.tail (-) @seen).keys.sort.Array; 
    
        if @seen == $n
        {
            if @seen.head + @seen.tail (elem) @squares
            {    
                return @seen
            }
    
            else
            {
                @seen.pop;
                @stack.pop
            }
        }

        while @stack.tail ~~ Empty
        {
            @seen.pop;  
            @stack.pop
        }

        return Empty unless @seen
    }

    sub squares($n)
    {
        my $squares := 2..* Z* 2..*;
        $squares.head: $squares.cache.first(* >= $n*2, :k)
    }
    
    sub graph($n)
    {
        gather for 1..$n -> $k
        {
            take $k => .Array given gather for 2..$n -> $v
            {
                next if $k == $v;
                take $v if $k + $v (elem) @squares
            }
        }
    }
}
