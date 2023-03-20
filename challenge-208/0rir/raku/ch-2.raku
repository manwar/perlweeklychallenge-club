#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.d;
use Test;

=begin comment
208-2: Duplicate and Missing    Submitted by: Mohammad S Anwar

Given an array of integers in sequence with one missing and one duplicate;
find the duplicate and missing integer in the given array. Return -1 if none
found.  Assume the array contains no more than one duplicate and missing.

Example 1:

Input: @nums = (1,2,2,4)
Output: (2,3)

Duplicate is 2 and Missing is 3.
Example 2:

Input: @nums = (1,2,3,4)
Output: -1

No duplicate and missing found.
=end comment

my @Test-bad = [];
my @Test =
    ( (1,),      Array,     ),
    ( (1,1),     Array,     ),
    ( (1,2),     Array,     ),
    ( (1,3),     Array,     ),
    ( (1,2,3,4), Array,     ),
    ( (1,1,3),   (1,2),     ),
    ( (1,3,3),   (3,2),     ),
    ( (2,2,3),   (2,1),     ),
    ( (2,3,3),   (3,4),     ),
    ( (1,2,3,3), (3,4),     ),
    ( (1,2,2,4), (2,3),     ),

    (( -10,       -10,     Empty, |(-8…10)),    (-10,  -9)),
    (( Empty,      -9,            |(-9…10)),    ( -9, -10)),
    (( |(-10…9),    9,            Empty   ),    (  9,  10)),
    (( |(-10…8), Empty,    10,    10      ),    ( 10,   9)),
    (( |(-10…0), Empty,     2,    |(2…10) ),    (  2,   1)),
    (( |(-10…0),   0,     Empty,  |(2…10) ),    (  0,   1)),

    (( -10000,         -10000,  Empty,  |(-9998…10000)),   (-10000,  -9999)),
    (( Empty,           -9999,          |(-9999…10000)),   ( -9999, -10000)),
    (( |(-10000…9999),   9999,          Empty,        ),   (  9999,  10000)),
    (( |(-10000…9998),  Empty,  10000,  10000         ),   ( 10000,   9999)),
    (( |(-10000…0),     Empty,  2,      |(2…10000)    ),   (     2,      1)),
    (( |(-10000…0),      0,     Empty,  |(2…10000)    ),   (     0,      1)),

    (( |(-100000…99998),  Empty,  100000,  100000     ),   ( 100000,  99999)),

    ( (-100…100), Array),
;

# too small
multi sub dupe-and-miss( @a where .end < 2 ) { Array }

# simplify fenceposts on full pass  TODO process tail not head micro-optim
multi sub dupe-and-miss( @a where @a[0] == @a[1] --> Array ) {
    when @a[2] > @a[1] + 1 {
        return [ @a.head, @a.head+1 ]
    }
    return [@a.head, @a.head -1  ];
}

# common case                  # above TODO  shave tail not head
multi sub dupe-and-miss( @a --> Any ) {
    for 1..^@a.end -> $i {
        if @a[$i] == @a[$i + 1] {
            if @a[$i-1] == @a[$i] -2 {
                return [ @a[$i], @a[$i] -1]
            } else {
                return [ @a[$i], @a[$i] +1]
    }   }   }
    return Array;
}

plan +@Test-bad + @Test;

for @Test-bad ->  @t {
    is dupe-and-miss( @t), Array, 'no match';
}

for @Test ->  ( @in, @exp) {
    is dupe-and-miss( @in), @exp, "&dupe-and-miss @in[0] to @in[@in.end]";
}

done-testing;

my @n = (-7…7),
        (|(-5…-2), 0, |(0…5));
for @n -> @num {
    print "\nInput: @num = @num[]\nOutput: ", &dupe-and-miss( @num) // -1;
}


