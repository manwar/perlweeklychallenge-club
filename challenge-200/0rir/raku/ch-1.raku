#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
Task 1: Arithmetic Slices       Submitted by: Mohammad S Anwar

Given an array of integers, find all Arithmetic Slices it contains.

An integer array is called arithmetic if it has at least 3 elements and the
differences between any three consecutive elements are the same.

Example 1
Input: @array = (1,2,3,4)
Output: (1,2,3), (2,3,4), (1,2,3,4)
Example 2
Input: @array = (2)
Output: () as no slice found.
=end comment

=begin interpretation
Not finding anything that seems to authoritatively define an Arithmetic
Slice.  I see 4 solutions:  Rising: 1,2,3,4,5.
Falling: 4,3,2,1.  Both: which may have constraints re overlaps 1,2,3,4,3,2.
And my choice absolute or Wavy: 1,2,1,2,3,2,3,2,1,2,3,4.
=end interpretation


constant MIN-LINKS = 3;

my @Test-delta-top =
    # in            deltas     max-runs  all-runs   out
    [[],            [],        [],       [],        [],                 ],
    [[0,1,4,9,15],  [1,3,5,6], [],       [],        [],                 ],
    [[1,2,1],       [1,1],     [[0,2],], [[0,2],],  [[1,2,1],]          ],
    [[1,1,2,1,1],   [0,1,1,0], [[1,3],], [[1,3],],  [[1,2,1],]          ],

    [[1,2,3,3,2,1], [1,1,0,1,1],        [[0,2],[3,5]], [[0,2],[3,5]],
                [[1,2,3],[3,2,1],]
    ],
    [[1,1,2,3,3,2,1,1], [0,1,1,0,1,1,0], [[1,3],[4,6]], [[1,3],[4,6]],
                [[1,2,3,3,2,1],]
    ], 
    [[1,1,2,3,3,2,1], [0,1,1,0,1,1],    [[1,3],[4,6]], [[1,3],[4,6]],
                [[ 1,2,3,3,2,1],]
    ],
    [[9,1,2,3,4,4,3,2,1,9], [8,1,1,1,0,1,1,1,8], [[1,4],[5,8]],
        [[1,3], [2,4], [1,4], [5,7], [6,8], [5,8],],
        [[1,2,3],[2,3,4],[1,2,3,4],[4,3,2],[3,2,1],[4,3,2,1],]
    ],
    [[1,2,3,4],     [1,1,1],   [[0,3],], [[0,2],[1,3],[0,3]],
        [[1,2,3],[2,3,4],[1,2,3,4]],
    ],
    [[1,2,3,4,5],   [1,1,1,1],      [[0,4],],
        [[0,2],[1,3],[2,4],[0,3],[1,4],[0,4]],
        [[1,2,3],[2,3,4],[3,4,5],[1,2,3,4],[2,3,4,5],[1,2,3,4,5]]
    ],
    [[1,2,3,4,5,5], [1,1,1,1,0],    [[0,4],],
        [[0,2],[1,3],[2,4],[0,3],[1,4],[0,4]],
        [[1,2,3],[2,3,4],[3,4,5],[1,2,3,4],[2,3,4,5],[1,2,3,4,5]]
    ],
    [[1,1,2,3,4,5], [0,1,1,1,1],    [[1,5],],
        [[1,3],[2,4],[3,5],[1,4],[2,5],[1,5]],
        [[1,2,3],[2,3,4],[3,4,5],[1,2,3,4],[2,3,4,5],[1,2,3,4,5]]
    ],
    [[1,1,2,3,4,5,5], [0,1,1,1,1,0],  [[1,5],],
        [[1,3],[2,4],[3,5],[1,4],[2,5],[1,5]],
        [[1,2,3],[2,3,4],[3,4,5],[1,2,3,4],[2,3,4,5],[1,2,3,4,5]]
    ],
    [   [9,1,2,3,4,9,9,1,2,3,4,5,6,9,2,1,2],
        [8,1,1,1,5,0,8,1,1,1,1,1,3,7,1,1],
        [[1,4],[7,12],[14,16]],
        [[1,3],[2,4],[1,4],
            [7,9],[8,10],[9,11],[10,12],
            [7,10],[8,11],[9,12],
            [7,11],[8,12],
            [7,12],
            [14,16],
        ],
        [[1,2,3],[2,3,4],[1,2,3,4],
            [1,2,3],[2,3,4],[3,4,5],[4,5,6],
            [1,2,3,4],[2,3,4,5],[3,4,5,6],
            [1,2,3,4,5], [2,3,4,5,6],
            [1,2,3,4,5,6],
            [2,1,2],
        ],
    ]
;

plan 5 × @Test-delta-top.elems; 

for @Test-delta-top -> @t {
    is my $R = get-deltas( @t[0]), @t[1],
            "in @t[0].raku() to delta";
    is top-runs( @t[1]), @t[2],
            "delta @t[1].raku() to top-runs";
    is sub-runs( @t[2]), @t[3],
            "top-runs @t[2].raku() to sub-runs";
    is range-to-slice( @t[0],@t[3]),@t[4],
            "sub-runs  @t[3].raku() to out";
    is slices( @t[0]),@t[4], "all-steps-combined";
}

done-testing;


multi slices( @in where *.end < MIN-LINKS -1, --> Array ) { [] }

multi slices( @in ) {
    my @dif = get-deltas( @in);
    range-to-slice( @in, 
        sub-runs(
            top-runs( @dif,  MIN-LINKS ), MIN-LINKS-1));
}


multi get-deltas( @in where *.end ≥ MIN-LINKS-2 ) {
    map { abs( $_[0] - $_[1]) }, @in.rotor(2 => -1); # XXX abs() see below.
}

# for testing only, callers constrain @in size
multi get-deltas( @in where *.end < MIN-LINKS-2) { [] }

sub top-runs( @dif, $min-links = MIN-LINKS, --> Array) {
    my $chain;          # Array size 2
    my @chain = [];     # A o A of indices to longest runs in @in.
    my $i = 0;
    while $i < @dif.end {
        while $i < @dif.end and @dif[$i] ≠ @dif[$i + 1] {       # hunt
            ++ $i;
        }
        # XXX Poor design choice.
        # Instead of using abs() in get-deltas(), using alternate comparison
        # functions in this if-statement could allow slices that are
        # constrained to rise, to fall, to rise, or be wavy.
        # Using abs() earlier eliminated info needlessly.
        if $i < @dif.end and ( @dif[$i] == @dif[$i + 1]) {      # found a link
            $chain = [ $i, ($ = $i+2)];
            ++ $i;

            while $i < @dif.end and @dif[$i] == @dif[$i + 1] {  # follow it
                ++ @$chain[1];
                ++ $i;
            }
            if @$chain[1] - @$chain[0] ≥ -1 + $min-links {     # keep it
                @chain.push: $chain;
            } 
            $chain = [];                                    # throw it back
        }
    }
    return @chain;
}

=begin pod

sub-runs( @chain, $min-size --> Array )

@chain contains dyads like, here two, [[6,9],[20,24]] denoting sequences
of successive integers.  This returns those and all shorter sequences they
contain which have at least $min-size elements.  Here with $min-size = 3
we have [[6,9],[6,8],[7,9], [20,24],[20,23],[21,24], [20,22],[21,23],[22,24]].

=end pod

sub sub-runs( @chain, $min-size = MIN-LINKS-1 --> Array ) {
    my @ret;
    return [] if @chain == []; # quick KLUGE -- missed the no sub-runs case

     for @chain -> @x {
        my ($head,$tail) = @x;
        my $span = $min-size;
        my $span-stop = $tail - $head;
        while $span ≤ $span-stop {
            my ($h, $t) = $head, $head + $span;
            while $t ≤  $tail {
                @ret.push: [$h<>,$t<>];                 #[[]] pair
                ++«($h, $t);                            #same t
            }
            ++ $span;
        }
    }

    # quick KLUGE -- missed the no sub-runs case
    return @chain if [] == @ret;
    return @ret;                                        #same t
}
=begin pod
sub range-to-slice( @in, @dyad --> Array ); 

Returns an AoA using values from @in. Each @dyad elem is used
as a range to create an element array in the returned array.
=end pod

sub range-to-slice( @in, @dyad --> Array ) {
    my @return;
    for @dyad -> ($a, $z) { @return.push: @in[ $a..$z] }
    @return;
}

my @array = [9,1,2,3,4,9,9,1,2,3,4,5,6,9,2,1,2];

my @abs-exp = [[1,2,3],[2,3,4],[1,2,3,4],
                [1,2,3],[2,3,4],[3,4,5],[4,5,6],
                [1,2,3,4],[2,3,4,5],[3,4,5,6],
                [1,2,3,4,5], [2,3,4,5,6],
                [1,2,3,4,5,6],
                [2,1,2]];

say "\n\nSolving arithmetic slices with absolute deltas.\n";
my @got = &slices( @array); 
say " Input: \@array = @array[]\n Output: ", @got;
die 'slice failed' unless @got ~~ @abs-exp;
