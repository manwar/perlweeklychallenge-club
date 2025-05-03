#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
318-Task 2: Reverse Equals      Submitted by: Roger Bell_West
You are given two arrays of integers, each containing the same elements as the other.

Write a script to return true if one array can be made to equal the other by reversing exactly one contiguous subarray.

Example 1
Input: @source = (3, 2, 1, 4)
       @target = (1, 2, 3, 4)
Output: true

Reverse elements: 0-2

Example 2
Input: @source = (1, 3, 4)
       @target = (4, 1, 3)
Output: false

Example 3
Input: @source = (2)
       @target = (2)
Output: true

=end comment

my @Test =
    # source                target                  result
    (3, 2, 1, 4),           (1, 2, 3, 4),           True,
    (1, 3, 4),              (4, 1, 3),              False,
    (2,),                   (2,),                   True,
    (),                     (),                     False,
    (1,2,3),                (2,1,3),                True,
    (1,1,1,5,5,2,2,2),      (2,2,2,5,5,1,1,1),      True

;
plan @Test ÷ 3;

multi task( @src where * ~~ Empty, @targ -->False) {}  # Nothing to swap.
multi task( @src, @targ -->Bool) {
    my @zeed = @src Z @targ;                           # interleave
    my $h = @zeed.first: :k, { .[0] ≠ .[1] } // Int;   # key of 1st diff
    return True if ! $h.defined;                       # no diff
    my $t = @zeed.first: :end, :k, { .[0] ≠ .[1] };    # key of last diff
    return @src[$t…$h] ~~ @targ[$h…$t];                # reverse and test
}

for @Test -> @src, @targ, $exp {
    die 'bad inputs' unless @src.sort == @targ.sort;
    is task( @src, @targ), $exp, "{$exp // $exp.^name()} <- @src[] ∘∘ @targ[]";
}
done-testing;

my @source = (3, 2, 1, 4);
my @target = (1, 2, 3, 4);

say qq{\nInput: @source = @source.raku()\n       @target = @target.raku() }
  ~ qq{\nOutput: &task( @source, @target)}

