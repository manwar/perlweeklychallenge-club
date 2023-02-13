#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.e.PREVIEW;
use lib $?FILE.IO.parent(2).add("lib");
use Test;
use Array::Sorted::Util;

=begin comment
203-1: Special Quadruplets          Submitted by: Mohammad S Anwar
Given an array of integers, find the total special quadruplets for the array.

Special Quadruplets are defined by the following 2 rules.
1) nums[a] + nums[b] + nums[c] == nums[d]
2) a < b < c < d

Example 1
Input: @nums = (1,2,3,6)
Output: 1

Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] == $nums[3].
Example 2
Input: @nums = (1,1,1,3,5)
Output: 4

$nums[0] + $nums[1] + $nums[2] == $nums[3]
$nums[0] + $nums[1] + $nums[3] == $nums[4]
$nums[0] + $nums[2] + $nums[3] == $nums[4]
$nums[1] + $nums[2] + $nums[3] == $nums[4]
Example 3
Input: @nums = (3,3,6,4,5)
Output: 0

=end comment

=begin comment

=end comment

my @Test =
    [] => [],
    [1,] => [],
    [1,2] => [],
    [1,2,3] => [],
    [1,2,3,4] => [],

    [1,2,3,6] => [[1,2,3,6],],
    [1,2,1,2,3,6] => [[1,2,3,6],[1,2,3,6],[1,2,3,6],],
    [3,3,6,4,5] => [],
    [0,1,2,3] => [[0,1,2,3],],
    [9,0,1,2,3] => [[0,1,2,3],],
    [9,0,1,2,3,4] => [[0,1,2,3],[0,1,3,4]],
    [9,0,1,2,3,4,5,6] => [
        [0,1,2,3],[0,1,3,4],[0,1,4,5],[0,1,5,6],[0,2,3,5],[0,2,4,6],[1,2,3,6]],

    [6,3,14,10,11,1,2,27,30,35] => [[6,10,11,27],[1,2,27,30]],

    [ 6,3,14,10,11,1,2,27,30,35,30] => [[6,10,11,27],[1,2,27,30],[1,2,27,30]],
;

plan 2 × +@Test;

# make an array of the same size with A o A[sum-of-2-num, index of 1st num]
sub _first-sums( @a --> Array) {
    my @presum = [] xx @a.elems;
    enum Sum <SUM IDX>;

    for 0..^@a-1 -> $i {
        for 1+$i ..^@a-1 -> $j {
            if @a[$i] < @a[$j] {
                @presum[$j].push: [ @a[$i] + @a[$j], $i];
    }   }   }
    return @presum;
}

sub special-quad-count( @a --> UInt ) {
    my @presum = _first-sums( @a);
    my $return = 0;
    for 0..^@presum -> $i {
        next if @presum[$i] ~~ Empty;
        for @presum[$i] -> @stack {
            for @stack -> @sum {
                for $i+1 ..^@a-1 -> $t {
                    next if @sum[SUM] - @a[@sum[IDX]] ≥ @a[$t];
                    $return += +@a[$t+1..^@a].grep( * ~~ @sum[SUM] + @a[$t]);
    }   }   }   }
    $return;
}

sub make-special-quads( @a --> Array ) {
    my @return;

    my @presum = _first-sums( @a);

    for 0..^@presum -> $i {
        next if @presum[$i] ~~ Empty;
        for @presum[$i] -> @stack {
            for @stack -> @sum {
                for $i+1 ..^@a-1 -> $t {
                    next if @sum[SUM] - @a[@sum[IDX]] ≥ @a[$t];
                    my @last = @a[$t+1..^@a].grep( * ~~ @sum[SUM] + @a[$t]);
                    for @last -> $fourth {
                        my $first   = @a[@sum[IDX]];
                        my $second  = @sum[SUM]-@a[@sum[IDX]];
                        my $third   = @a[$t];
                        @return[+*] = [ $first, $second, $third, $fourth];
    }   }   }   }   }
    @return;
}

for @Test -> ( :key(@in), :value(@exp)) {
    is special-quad-count(@in), @exp.elems, 'count';
    is-deeply make-special-quads(@in), @exp, "@in.raku() => @exp.raku()";
}

my  @num = [ 6,3,14,10,11,1,2,27,30,35,30];

say "\nInput: \@nums = @num[]\nOutput: &special-quad-count(@num)";
