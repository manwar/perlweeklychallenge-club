#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.e.PREVIEW;
use Test;

=begin comment
207-2: H-Index              Submitted by: Mohammad S Anwar
Given an array of integers containing citations a researcher has received
for each paper, compute the researcher’s H-Index. For more information
please checkout the wikipedia page.

The H-Index is the largest number h such that h articles have at least h
citations each. For example, if an author has five publications, with 9, 7,
6, 2, and 1 citations (ordered from greatest to least), then the author’s
h-index is 3, because the author has three publications with 3 or more
citations. However, the author does not have four publications with 4 or
more citations.  

Example 1
Input: @citations = (10,8,5,4,3)
Output: 4

Because the 4th publication has 4 citations and the 5th has only 3.
Example 2
Input: @citations = (25,8,5,3,3)
Output: 3

The H-Index is 3 because the fourth paper has only 3 citations.

=end comment

my @Test =
    [ (), 0],
    [ (0,), 0],
    [ (0,0,0), 0],
    [ (1,), 1],
    [ (∞,), 1],
    [ (∞,∞), 2],
    [ (1,∞,1,∞,∞), 3],
    [ (1,∞,∞,1), 2],
    [ (1,∞,1,1), 1],
    [ (10,), 1],
    [ (0,0,1), 1],
    [ (10,8,5,4,3), 4 ],
    [ (25,8,5,3,3), 3 ],
;
plan +@Test;

sub h-index( $l = (10,8,5,4,3) --> Int ) {
    my $r = $l.sort({$^b <=> $^a})
              .pairs
              .List
              .first( {.key ≤ .value -1}, :end)
              .key;
    // $r ?? $r + 1 !! 0;
}

for @Test -> ($t, $exp) {
    is h-index($t), $exp, "$exp <- $t.Str()";
}
done-testing;
my @citations = (0,0,1,0,3,2,7,∞,∞,∞);
say "\nInput: @citations = @citations[]\nOutput: ", h-index(@citations);
exit;
