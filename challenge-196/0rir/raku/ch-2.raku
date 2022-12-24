#!/usr/bin/env raku 
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.e.PREVIEW;
use Test;

=begin comment
196-2: Range List           Submitted by: Mohammad S Anwar
Given a sorted unique integer array, @array, find all possible Number
Range i.e [x, y] represent range all integers from x and y (both inclusive).

Example 1
Input: @array = (1,3,4,5,7)
Output: [3,5]
Example 2
Input: @array = (1,2,3,6,7,9)
Output: [1,3], [6,7]
Example 3
Input: @array = (0,1,2,4,5,6,8,9)
Output: [0,2], [4,6], [8,9]
=end comment

multi MAIN (@array = (9...90, 1_001,1_002,1_003,1_004) ) { 
    say "Input: @array =  @array.raku()\n
Output: ",          my @r = get-ranges( @array);;
    die 'wrong' unless @r eqv [9,90],[1_001,1_004];
}

multi MAIN ( 'test' ) {
    my @Test =
        { in => Empty,         exp => [], },
        { in => 99999,         exp => [], },
        { in => [1,2],         exp =>  [1,2], },
        { in => [1,2,3],       exp =>  [1,3], },
        { in => [5,6,9],      exp =>  [5,6], },
        { in => [1...7,9],     exp =>  [1,7], },
        { in => [1,3,5,7,9],   exp => [] },
        { in => [1,2,3,6,7,9], exp => [ 1,3, 6,7], },
        { in => [2,3,6,7,9],   exp => [ 2,3, 6,7], },
        { in => [2,3,100_006,100_007,100_008],
            exp => [ 2,3, 100_006,100_008], },
        { in => [5,6,7, 1_000_001,1_000_002,1_000_003,1_000_004],
            exp => [ [5,7],[1_000_001,1_000_004]] },
        { in => [ 9...99_000, 1_000_001,1_000_002,1_000_003,1_000_004],
            exp => [ [9,99_000],[1_000_001,1_000_004]] },
    ;
    plan +@Test;
    for @Test -> %t {
        my @in  = |%t<in>;
        my $exp = %t<exp>;
        quietly is get-ranges( @in), $exp , @in.gist ~" --> "~ $exp.raku;
    }
    done-testing;
}

sub get-ranges( @a --> Array ) {
    return [] if @a ~~ Empty or 1 == @a.elems;
    my @return = Empty;
    my @w = @a.pairs;
    my $hd-idx = 0;
    while $hd-idx < @w.end {
        my $offset = @w[$hd-idx].value - @w[$hd-idx].key;
        my $tail = @w[1+$hd-idx..@w.end].first(
                    { .value - .key == $offset}, :end );
        with $tail {
            @return.push: [ @w[$hd-idx].value, $tail.value];
            $hd-idx = $tail.key;
        }
        ++$hd-idx;
    }
    return @return;
}
