#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
300-Task 2: Nested Array        Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints of length n containing permutation of the numbers in the range [0, n - 1].
Write a script to build a set, set[i] = ints[i], ints[ints[i]], ints[ints[ints[i]]], ..., subjected to the following rules:

1. The first element in set[i] starts with the selection of elements ints[i].
2. The next element in set[i] should be ints[ints[i]], and then ints[ints[ints[i]]], and so on.
3. We stop adding right before a duplicate element occurs in set[i].
Return the longest length of a set set[i].

Example 1
Input: @ints = (5, 4, 0, 3, 1, 6, 2)
Output: 4

ints[0] = 5
ints[1] = 4
ints[2] = 0
ints[3] = 3
ints[4] = 1
ints[5] = 6
ints[6] = 2

One of the longest sets set[k]:
set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}
Example 2
Input: @ints = (0, 1, 2)
Output: 1

=end comment

my @Test =
    Int, [],
    Int, (),
    4,  (5, 4, 0, 3, 1, 6, 2),
    1,  (0, 1, 2),
    3,  (1, 2, 0),
    2,  (4, 1, 2, 3, 0),
    3,  (4, 1, 2, 3, 5, 0),
    4,  (4, 0, 2, 3, 5, 1),
    3,  (@ = flat do for 0,  3,  6…300 -> $v { $v+1,   $v+2, $v }),
    100,(@ = flat do for 0,100,200…300 -> $v { $v+1...$v+99, $v }),
;

plan 2 × @Test ÷ 2;

#  Start a hash, as a set, for each element of input, enlarge all sets together.
multi task-by-idx( []                ) { Int }
multi task-by-idx( @in is copy --> Int) {
    my %sets = @in.pairs.map: { .key => [ .value, ] };  # Init a set w/ each val.
    my $count;
    while %sets.keys {              # If possible, push one value to each set.
        ++ $count;                    # Count the prior work.
        for %sets.keys -> \k {
            if %sets{k}.any ≠  @in[%sets{k}.tail] {
                %sets{k}.push: @in[%sets{k}.tail]       # Add value to set…
            } else {
                %sets{k} :delete;     # or delete the finished set.
            }
        }
    }
    $count;
}

multi task-by-exclusion( []  )         { Int }
multi task-by-exclusion( @in is copy --> Int) {
    my %h-ary = @in.kv;     # W/o reason, think a hash efficient vs. array :erase.
    my $ret;                # Score.
    while %h-ary {                            # Having a hash …
        my @nest = %h-ary.keys.min;           # start and … 
        while %h-ary{@nest.tail} ≠ @nest.any {
            @nest.push: %h-ary{@nest.tail}    # … finish a set.
        }
        $ret max= +@nest;                     # Register the score.
        %h-ary{@nest} :delete;                # Delete its elem's from workset.
    }
    $ret;
}

for @Test -> $exp, @in {
    is task-by-idx(@in), $exp, ($exp // 'Int') ~ " <- @in.raku()";
    is task-by-exclusion(@in), $exp, ($exp // 'Int') ~ " <- @in.raku()";
}

done-testing;

my $int = (1,2,0, 4,5,3, 7,8,6, 10,11,9, 13,14,12, 16,17,15, 19,20,18);

say "\nInput: \$int = $int.raku()\nOutput: { task-by-exclusion $int }";

