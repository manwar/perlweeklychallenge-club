#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
226-1: Shuffle String       Submitted by: Mohammad S Anwar
Given a string and an array of indices of same length as string, return the
string after re-arranging the indices in the correct order.

Example 1
Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)
Output: 'challenge'
Example 2
Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)
Output: 'perlraku'
=end comment

my @Test =
    'lacelengh', 'challenge', [3,2,0,5,4,8,6,7,1],
    'rulepark',   'perlraku',  [4,7,3,1,0,5,2,6],
;
plan @Test ÷ 3;

sub func( $l, @i -->Str) {
    my @word = $l.comb;
    my @return;
    sink @word.map: { @return[@i[$++]] = @word[$++] };
    @return.join;
}

for @Test -> $in, $out, @in {
    is func($in, @in ), $out, "$out <- $in [ @in[] ]";
}
done-testing;

my $string = 'lacelengh';
my @indices = (3,2,0,5,4,8,6,7,1);
say "\nInput: \$string = '$string', @indices = (3,2,0,5,4,8,6,7,1)
Output: '&func($string, @indices)'";

