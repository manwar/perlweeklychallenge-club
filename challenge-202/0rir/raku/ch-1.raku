#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment
202-1: Consecutive Odds         Submitted by: Mohammad S Anwar

Given an array of integers, print 1 if there are THREE consecutive
 odds in the array otherwise print 0.

Example 1
Input: @array = (1,5,3,6)
Output: 1
Example 2
Input: @array = (2,6,3,5)
Output: 0
Example 3
Input: @array = (1,2,3,4)
Output: 0
Example 4
Input: @array = (2,3,5,7)
Output: 1
=end comment

my @Test = (7,) => 0,       (7,7) => 0,     (7,3,7) => 1,     (7,7,8) => 0,
        (7,8,7) => 0,     (8,7,7) => 0,     (8,7,8) => 0,     (8,8,7) => 0,
    (7,7,7,7)   => 1,   (7,7,7,8) => 1,   (7,7,8,7) => 0,   (8,7,7,7) => 1,
    (7,7,7,8,7) => 1, (7,7,8,7,7) => 0, (7,8,7,7,7) => 1, (8,7,7,7,8) => 1,
;

# Return true if exists a run of $length of nums where &req is true 
sub find-seq( @a, $length, &req -->Bool) {

    my $offset = $length - 1;
    my $head-tail = @a.end - $offset;

    while $head-tail ≥ 0 {
        ($head-tail = @a[0..$head-tail].first({ &req( $_)}, :k :end))
            //
            return False;

        return True if @a[$head-tail^..$head-tail+$offset]».&req.all;
                --$head-tail;
    }
    return False;
} 

sub is-odd( Int $a) { ?($a%2) }

sub odd-trio( @a --> Int ) { find-seq( @a, 3, &is-odd).Int }

plan @Test.elems();

for @Test -> (:key(@l), :value($exp)) {
    is odd-trio(@l), $exp, "@l[] --> $exp";
}
done-testing;

my @ary = 2,3,5,7;
say "\nInput: @array = @ary[]\nOutput: ", odd-trio( @ary);

