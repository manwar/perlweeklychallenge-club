#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
303-1: 3-digits Even        Submitted by: Mohammad Sajid Anwar

You are given a list (3 or more) of positive integers, @ints.

Write a script to return all even 3-digits integers that can be formed using the integers in the given list.

Example 1
Input: @ints = (2, 1, 3, 0)
Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)
Example 2
Input: @ints = (2, 2, 8, 8, 2)
Output: (222, 228, 282, 288, 822, 828, 882)
=end comment

my @Test =
    # @in           @exp
    [2,2,8,8,2],        [222,228,282,288,822,828,882],
    [2,1,3,0],          [102,120,130,132,210,230,302,310,312,320],
    [],                 [],
    [1234],             [],
    [100,100,101,404],  [100,404],
    [1,2,3,4],          [124,132,134,142,214,312,314,412,234,324,342,432],
    [1,2,3,4],          [124,132,134,142,214,312,314,412,234,324,342,432],
    [20,10,1000,1,2,],  [102,110,120,202,210,220],
;
plan @Test ÷ 2;

# Validate -- upper limit handled elsewhere.
sub is-valid( Any(Int) $in --> Bool) { $in.defined and $in > 99 and $in %% 2 }


sub task( @a is copy) {
    my (@candi, @one, @two, @three);

    my %by-size = @a.grep( * < 1000 ).classify: *.chars;

    @one   = %by-size{1}.flat;
    @two   = %by-size{2}.flat;
    @three = %by-size{3}.flat;

    for @three -> $t { @candi.push($t) if $t.&is-valid; }

    for @one.combinations(3)».Array -> @c {
        for @c.permutations -> @p {
            my $p = @p.join;
            @candi.push($p) if $p.&is-valid;
        }
    }


    quietly
        my @mixed = ( ( @one   X,  @two )».join).Array
             .append( ( @one R[X,] @two )».join);

    @candi.append: @mixed.grep( *.&is-valid);

    return @candi.unique;
}

for @Test -> @in, @exp {
    is task(@in).sort,  @exp.sort, "@exp.raku() <≡ task @in[]";
}

done-testing;

my @int = 1, 89, 54, 700546, 12, 37;
say "\nInput: @ints = @int.raku()\nOutput: { task @int }";



