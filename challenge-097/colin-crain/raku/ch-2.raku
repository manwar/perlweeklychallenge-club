#!/usr/bin/env perl6
#
#
#       flippenbitter.raku
#
#         TASK #2 › Binary Substrings
#         Submitted by: Mohammad S Anwar
#         You are given a binary string $B and an integer $S.
# 
#         Write a script to split the binary string $B of size $S and then find
#         the minimum number of flips required to make it all the same.
# 
#         Example 1:
#         Input: $B = “101100101”, $S = 3
#         Output: 1
# 
#         Binary Substrings:
#             "101": 0 flip
#             "100": 1 flip to make it "101"
#             "101": 0 flip
#         Example 2:
#         Input $B = “10110111”, $S = 4
#         Output: 2
# 
#         Binary Substrings:
#             "1011": 0 flip
#             "0111": 2 flips to make it "1011"
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $size = 3, Str $bin = "110001011101010111001010101010010000111101111000") ;

die "$size does not evenly divide length of $bin" unless $bin.chars %% $size;

## section into equal sized parts and convert to decimal
my @sections = $bin.comb($size).map({.parse-base(2)});

## establish flips required to equalize to each value in list
my @flips.push( bitflips($_, @sections) ) for 0..@sections.end;

## report minimum
say qq:to/__END__/;
    binary string : $bin
    segment size  : $size
    bits flipped  : { @flips.min }
    __END__

sub bitflips( Int $idx, @sections ) {
## xor each pair with indexed value and sum
    my $flips = 1;
    @sections.map({ ($_ +^ @sections[$idx]).base(2)
                                           .comb 
                                           .sum })
             .sum;
}
