#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited.
291-2: Arrange Box         Submitted by: Mohammad Sajid Anwar

You are given an array of box dimensions. Write a script to determine
the maximum number of these boxes that can fit inside each other in a
single stack. For a box to fit inside another, it must be smaller in
both dimensions.

Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
Extract heights: (20, 18, 10, 25, 30)
[15, 10] -> [16, 25] -> [20, 30]
=end comment

# boxes may not be rotated for nesting

my @Test =
        # in                                               exp 
    ([1, 3], [3, 5], [6, 8], [2, 4]),                       4, 
    ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3]),               3,
    ([5, 5], [5, 5], [5, 5]),                               1,
    ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400]),      4,
    ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25]),     3,
    [],                                                   Int,
    ([1,1],),                                               1,
;
plan +@Test ÷ 2;

sub infix:<nests-in>( $a, $b -->Bool:D) {
    return False if $a[0] ≥ $b[0]  or  $a[1] ≥ $b[1] ;
    True;
}

multi task( [] ) { Int}
multi task( @a -->Int:D) {
    my @work = @a.sort: { .[0], .[1] };
    my $ret = 1;
    my ($cur, $candi)  = 0,1;
    while $candi <  @work {
        if @work[$cur] nests-in @work[$candi] {
            ++$ret; 
            $cur = $candi;
            ++$candi;
        } else {
            ++$candi;
        }
    }
    $ret;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my @boxes = [4, 5], [4, 6], [6, 7], [2, 3], [4, 3];

say qq{\nInput: \@boxes = @boxes.raku()\nOutput: }, task @boxes;
