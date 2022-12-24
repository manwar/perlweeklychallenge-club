#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.e.PREVIEW;
use Test;

=begin comment
196-1: Pattern 132              Submitted by: Mohammad S Anwar
Given a list of integers, @list, find all subsequence that respect Pattern 132. Return empty array if none found.

Pattern 132 is a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < a[k] < a[j].

Example 1
Input:  @list = (3, 1, 4, 2)
Output: (1, 4, 2) respect the Pattern 132.
Example 2
Input: @list = (1, 2, 3, 4)
Output: () since no susbsequence can be found.
Example 3
Input: @list = (1, 3, 2, 4, 6, 5)
Output: (1, 3, 2) if more than one subsequence found then return the first.
Example 4
Input: @list = (1, 3, 4, 2)
Output: (1, 3, 2)
=end comment

=begin comment
The spec says to find all triads and to return only the first.  Doing both.
"First" commonly means the sequence starting with the left-most head and, as
a tie breaker, ending with left-most tail, and, as a second tie breaker,
having the left-most body.  That is the definition used here.
=end comment

multi MAIN ( 'test' ) {
    #      input,  expect-single, expect
    my @Test =
        ( [],            [], [],),
        ( [1,],          [], [],),
        ( [1,2],         [], [],),
        ( [1,2,3],       [], [],),
        ( [1,2,3,4],     [], [],),
        ( [1,2,3,4,5],   [], [],),
        ( [0,1,2,3,4,5], [], [],),
        ( [1,1,1],       [], [],),
        ( [1,1,2],       [], [],),
        ( [1,2,1],       [], [],),
        ( [2,1,1],       [], [],),
        ( [2,2,1],       [], [],),
        ( [2,2,2],       [], [],),

        ( [ -1,2,1],     [-1,2,1], [[ -1,2,1],]),

        ( [1,4,2],       [1,4,2], [[1,4,2],],),
        ( [3,1,4,2],     [1,4,2], [[1,4,2],],),
        ( [3,1,4,2,5],   [1,4,2], [[1,4,2],],),

        ( [1,4,6,4,3,5,10],
                [1,6,4],
                [[1,4,3],[1,4,3],[1,6,3],[1,6,4],[1,6,5],[4,6,5]],), #dupes
        ( [10,1,4,6,4,3,5],
                [1,6,4],
                [[1,4,3],[1,4,3],[1,6,3],[1,6,4],[1,6,5],[4,6,5]],), #dupes
        ( [10,1,4,6,4,3,5,10],
                [1,6,4],
                [[1,4,3],[1,4,3],[1,6,3],[1,6,4],[1,6,5],[4,6,5]],), #dupes
        ( [1,2,3,4], [], [],),
        ( [1,3,2,4,6,5],
                [1,3,2],
                [[1,3,2],[1,6,5],[3,6,5],[2,6,5],[4,6,5]],),
        ( [1,1,3,4,2,1,1,1],
                [1,3,2],
                [[1,3,2],[1,4,2],[1,3,2],[1,4,2] ] ),   #dupes

        ( [42,95,17,4,25,51,25,36,38,85,82,13,63,8],
          [42,95,51], 
          [
          [ 4,13, 8],
          [ 4,25, 8], [ 4,25, 8], [ 4,25,13], [ 4,25,13],   # dupes
          [ 4,36, 8], [ 4,36,13],
          [ 4,38, 8], [ 4,38,13], [ 4,51, 8], [ 4,51,13], [ 4,51,25],
          [ 4,51,36], [ 4,51,38], [ 4,63, 8], [ 4,82, 8], [ 4,82,13],
          [ 4,82,63], [ 4,85, 8], [ 4,85,13], [ 4,85,63], [ 4,85,82],
          [17,51,25], [17,51,36], [17,51,38], [17,82,63], [17,85,63],
          [17,85,82],
          [25,51,36], [25,51,38],
          [25,82,63], [25,82,63],                           # dupes
          [25,85,63], [25,85,63],                           # dupes
          [25,85,82], [25,85,82],                           # dupes
          [36,82,63], [36,85,63], [36,85,82],
          [38,82,63], [38,85,63], [38,85,82],
          [42,82,63], [42,85,63], [42,85,82], [42,95,63],
          [42,95,51], [42,95,82], [42,95,85],
          [51,82,63], [51,85,63], [51,85,82],
          ],
        ),
    ;

    plan 2 × @Test;
    for @Test -> @a {
        my @in = @a[0];
        my @single-exp = @a[1];
        my @exp = @a[2];
        my @ans = get132triads(@in );
        is-deeply @ans.sort, @exp.sort, "Test: " ~ @in.raku;
        is-deeply get132triad( @in), @single-exp, 'Test single: ' ~ @in.raku;
    }
    done-testing;
}

sub get132triad( @in --> Array ) {
    return [] if @in ~~ Empty;
    return [] if @in.elems < 3;
    get132triads( @in, :single);
}

sub get132triads( @in, Bool :$single --> Array ) {
    return [] if @in ~~ Empty;
    return [] if @in.elems < 3;

    my ($head, $tail, @caught, @ret) = 0, 2;
    while $head < @in.end -1 {
        while $tail < @in.elems {
            if @in[$tail] ≤  @in[$head] {
                ++ $tail;
                next;
            }
            @caught = (@in[$head^..^$tail].grep: * > @in[$tail]); #.unique;
            for @caught -> $m {
                @ret.push: [ @in[$head], $m, @in[$tail]];
                once if $single { return  @ret[0]<>; } 
            }
            ++ $tail;
        }
        ++ $head;
        $tail = $head + 2;
    }
    return @ret;
}

multi MAIN( @list = [42,95,17,4,25,51,25,36,38,85,82,13,63,8]) {
    say "Input:  \@list = @list.raku()
Output: ",          my @res = get132triad( @list);
    die 'wrong' unless @res eqv [42,95,51];
}
