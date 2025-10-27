#!/usr/bin/env raku,
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;
#use MONKEY-SEE-NO-EVAL;     # unnecessary w/ Test module


=begin comment
Edited for space.
344-Task 2: Array Formation
Submitted by: Mohammad Sajid Anwar
You are given two list: @source and @target.

Write a script to see if you can build the exact @target by putting these smaller lists from @source together in some order. You cannot break apart or change the order inside any of the smaller lists in @source.

Input: @source = ([2,3], [1], [4])
       @target = (1, 2, 3, 4)
Output: true
Use in the order: [1], [2,3], [4]

Example 2
Input: @source = ([1,3], [2,4])
       @target = (1, 2, 3, 4)
Output: false

Example 3
Input: @source = ([9,1], [5,8], [2])
       @target = (5, 8, 2, 9, 1)
Output: true

Use in the order: [5,8], [2], [9,1]

Example 4
Input: @source = ([1], [3])
       @target = (1, 2, 3)
Output: false

Missing number: 2

Example 5
Input: @source = ([7,4,6])
       @target = (7, 4, 6)
Output: true

Use in the order: [7, 4, 6]
=end comment

my @Test =
    #  @src                     @targ               $exp
                # one chunk
    ( ['abc'],),                <a b c>,           True,
    ( ['abc'],),                <a c b>,           False,
    ( ['abc'],),                <a b>,             False,
                # size mismatch
    ([1], [3]),                 (1, 2, 3),         False,       # given
    ([7,4,6,4]),                (7, 4, 6),         False,
    ([7,4,6,4]),                (7, 4, 6, 4, 4),   False,
                # all chunks one loca
    ([2,3], [1], [4]),          (1, 2, 3, 4),      True,        # given
    ([9,1], [5,8], [2]),        (5, 8, 2, 9, 1),   True,        # given

                # analyze -- with multi loca
    (['a'], ['a'], ['a','a']),  <a a a a>,         True,
    ([7,4,6,4]),                (7, 4, 6,4),       True,

                # top level no match
    ([9,1,1], [5,8], [2]),      (1, 5, 8, 2, 9, 1),   False,
    ([1,3], [2,4]),             (1, 2, 3, 4),      False,       # given


    ([7,4,6]),                  (7, 4, 6),         True,        # given


    # have one-loca and multi-locae words
    ([4],[7],[6,4],[4]),        (7, 4, 6, 4, 4),   True,
    ([2,3], [1], [2,3], [4]),   (1, 2, 3, 4, 2,3), True,
;

plan @Test ÷ 3;

sub task( @have, @want -->Bool) {

        # quick checks
    if 1 == +@have {
        return @want.join eq @have[0].join ?? True !! False;
    }
        # check matching size and chars
    return False unless @have.flat( :hammer).sort ~~ @want.sort;

    # restructure inputs
    my @word = @have.map: { $_.elems > 0  ?? .join !! $_};
    my $goal = @want.join;

    # taint check
    @word.join ~~ m/ [<:L> | <:Nd>]+/;

    # Build a grammar
    my $code = 'grammar {
    rule TOP {  ^ <word>+ $ }
    token word {';

    $code ~= " | $_" for @word;
    $code ~= "    }\n}\n";

    my $gram-obj = (EVAL $code).new;
    so $gram-obj.parse: $goal;
}

for @Test -> @in, @want, $exp {
    is task( @in, @want), $exp,
            "{$exp // $exp.^name()} <- @in.raku() ∘∘ @want.raku()";
}
done-testing;

my @source = [[7,4,6], 7, 7, [7,1,2], 7, [7,1,7], 7];
my @target =   7,  7,4,6, 7,  1,2,7,  7,  1,7,7,  7;

say "\nInput: @source = @source.raku()\n       @target = @target.raku()\n"
  ~ "Output: ", lc task @source, @target;



