#!/home/rir/Repo/rakudo/install/bin/raku
##!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.e.PREVIEW;
use Math::Matrix;
use Test;

say %*ENV<VERSION>;

=begin comment
251-2: Lucky Numbers        Submitted by: Mohammad S Anwar
You are given a m x n matrix of distinct numbers.
Write a script to return the lucky number, if there is one, or -1 if not.
A lucky number is an element of the matrix such that it is
the minimum element in its row and maximum in its column.

Example 1
Input: $matrix = [ [ 3,  7,  8],
                   [ 9, 11, 13],
                   [15, 16, 17] ];
Output: 15

15 is the only lucky number since it is the minimum in its row
and the maximum in its column.
Example 2
Input: $matrix = [ [ 1, 10,  4,  2],
                   [ 9,  3,  8,  7],
                   [15, 16, 17, 12] ];
Output: 12
Example 3
Input: $matrix = [ [7 ,8],
                   [1 ,2] ];
Output: 7
=end comment


my @Test =
    12,     [ [ 1,  10,  4,  2],
              [ 9,  3,  8,  7],
              [15, 16, 17, 12] ],
    15,     [ [ 3,  7,  8],
              [ 9, 11, 13],
              [15, 16, 17] ],
    7,      [ [7 ,8],
              [1 ,2] ],
;
plan @Test ÷ 2;

sub ____ (+@list) { gather @list.deepmap: *.take }   # move to Flatland

the-lucky-number-is();

sub the-lucky-number-is( @a = @Test[1] --> Int) {
    my @w = @a.&____.sort;
say @w.raku;
    die 'Non-distinct data' unless @w.sort eqv @w.unique.sort;

    my @lucky;

    my @row-min = @a.map( *.min( :p)[0]);                   # ??????
    for @row-min -> $p {
say $p;
say "A col-max ", (@a[ 0..^@a, $p.key]).max; 
        my $col-max = @a[ 0..^@a, $p.key].max; 
        @lucky.push( $p.value) if $col-max == $p.value;
    }
    say @lucky.raku;
    return @lucky;
}
=finish

for @Test -> $exp, $in {
    is the-lucky-number-is($in), $exp, "$exp <- $in";
}

done-testing;
my @X = X;

exit;

