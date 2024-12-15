#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT die 'Rakudo version is too old; need max with named args.'
     unless $*RAKU.compiler.version cmp v2023.07 == More;
use Test;

=begin comment
298-2: Right Interval       Submitted by: Mohammad Sajid Anwar
You are given an array of @intervals, where $intervals[i] = [starti, endi] and each starti is unique.

The right interval for an interval i is an interval j such that startj >= endi and startj is minimized. Please note that i may equal j.

Write a script to return an array of right interval indices for each interval i. If no right interval exists for interval i, then put -1 at index i.

Example 1
Input: @intervals = ([3,4], [2,3], [1,2])
Output: (-1, 0, 1)

There is no right interval for [3,4].
The right interval for [2,3] is [3,4] since start0 = 3 is the smallest start that is >= end1 = 3.
The right interval for [1,2] is [2,3] since start1 = 2 is the smallest start that is >= end2 = 2.
Example 2
Input: @intervals = ([1,4], [2,3], [3,4])
Output: (-1, 2, -1)

There is no right interval for [1,4] and [3,4].
The right interval for [2,3] is [3,4] since start2 = 3 is the smallest start that is >= end1 = 3.
Example 3
Input: @intervals = ([1,2])
Output: (-1)

There is only one interval in the collection, so it outputs -1.
Example 4
Input: @intervals = ([1,4], [2, 2], [3, 4])
Output: (-1, 1, -1)

=end comment

# ri is min( start_candi) where  start_ri ≥ end 
my @Test =
    # (in [ start, end]             exp
=begin x
=end x
    [[3,4], [2,3], [1,2],],          (-1, 0, 1),
    [[1,4], [2,3], [3,4],],          (-1, 2, -1),
    [[1,2],],                        (-1,),
    [[1,4], [2, 2], [3, 4],],        (-1, 1, -1),
    [[1,4], [2, 2], [3, 4],],        (-1, 1, -1),
    [[3,4], [2,3], [1,2], [4,4],],   ( 3, 0, 1, 3),
    [[5,50],[7,10],[11,20],[12,19]], (-1, 2, -1, -1),
;
plan @Test ÷ 2;

enum Idx < Start End Key >;

# RI defined by constaints:  min( start_candi) where start_ri ≥ my.end 
sub task( @a ) {
    {
        my $key = 0;
        @a.=map: { [ $_[Start], $_[End], $key++ ] };
    }
    return do for @a -> @e {
        my @candi = @a.grep( *[Start] ≥ @e[End]);
        given @candi {
            when [] { -1 }                                  # none 
            when .elems == 1 { $_[0][Key] }                 # one
            default {
                    # .min(:k) returns a List of one idx
                @candi[ @candi.map( *[Start] ).min( :k ) ][0][Key];
            }
        }
    }
}

for @Test -> @in, @exp {
    is task(@in), @exp, "@exp.raku() <- @in.raku()";
}

done-testing;

my @interval = [1,4], [2, 2], [3, 4], [10, 50];
say "\nInput: @interval = @interval.raku()\nOutput: {task @interval}";

