#! /opt/local/bin/perl
#
#       flippenbitter.pl
#
#         TASK #2 › Binary Substrings
#         Submitted by: Mohammad S Anwar
#         You are given a binary string $B and an integer $S.
# 
#         Write a script to split the binary string $B of size $S and then find
#         the minimum number of flips required to make it all the same.
# 
#         Example 1:
#             Input: $B = “101100101”, $S = 3
#             Output: 1
#     
#             Binary Substrings:
#                 "101": 0 flip
#                 "100": 1 flip to make it "101"
#                 "101": 0 flip
# 
#         Example 2:
#             Input $B = “10110111”, $S = 4
#             Output: 2
#     
#             Binary Substrings:
#                 "1011": 0 flip
#                 "0111": 2 flips to make it "1011"
# 
#         method:
#             I rather enjoy these odd little puzzles with a lot of small moving
#             parts working towards some exotic goal. In this one we need to
#             segment the initial string, making sure it divides out evenly,
#             then compare the bits in each segment against those in all of the
#             remaining segments, calculating the changes required to alter the
#             other to match the first, then sum the results for the list.
#             Finally, after comparing each section the minimum sum among all
#             the sections, representing the most efficiant way to go about
#             things, will be the result requested. The given goal, the number
#             of bits flipped to equalize the segments to one of the values
#             without specifiying which, does not serve any obvious practical
#             purpose in itself. It could be a widget in a longer chain of data
#             processing, but who knows? This robs us the opportunity to provide
#             background and commentary on the context, but on the other hand
#             allows us to focus on the quiltwork: stiching together smaller
#             disparate ideas to form a cohesive whole. 
# 
#             Whew!
# 
#             Ok so let's break that down again:
#             - make sure the division is even (or it makes no sense)
#             - for each segment:
#                 - convert to decimal
#                 - xor with other segments to find bit differences
#                 - sum different bits for entire list
#                 - compare aginst and possibly replace a running minimum of flips required

#             There are a couple of implementation notes to go along with this
#             sequence of actions. One is in identifying which bits between two
#             binary strings are different. We can cut straight to the meat of
#             the matter by using a binary XOR on the two strings; identical
#             bits either 0 or 1 will produce a zero, differences will produce a
#             1. As we want the *number* of differences and don't care about the
#             structure, we can get this by summing the bits in the XOR result.
# 
#             This seems much more efficiant that breaking apart the binary
#             strings and directly comparing bits, but there's a caveat: the
#             bitwise operators work on *decimal* numbers, necessatating a
#             conversion to base-10, and to sum the bits it's easiest to work in
#             binary. Fortunately it's easy to switch back and forth.
# 
#             Another refactoring we can make is that once we have originally
#             produced the bitstring segments we no longer ever need to see them
#             in binary notation, so we can immediately convert the list of
#             values to base-10. This cleans up the code underneath, at the
#             expense of easily debugging exactly what's happening in the binary
#             notation. But, as I said, a refactor move. We've eliminated
#             printing some internal variables to peek in on the action, and
#             we're honing a process that's vetted.
# 
#             
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

sub minflips {
## given a segment length and binary bitstring,
## segment the binary string and determine the minimum flips required to 
## produce consistency among sections, using any section as the model
    my ($size, $bin) = @_;
    return undef if length($bin)%$size;
    my @sections;
    
    ## section into equal sized parts and convert to decimal
    push @sections, oct('0b'.substr($bin, 0, $size, '')) while length $bin > 0;

    my $min = "Inf";
    for ( 0..$#sections ) {
        my $flips = bitflips($_, @sections);
        $min = $flips if $flips < $min;
    }

    return $min;
}

sub bitflips {
## given a list of decimal numbers and an index,
## compute the number of flipped bits to transform all numbers in the list
## to the value indicated at index $idx
    my ($idx, @sections) = @_;
    my $flips = 0;
    for my $sect (@sections) {
        my $xored = sprintf "%b", $sections[$idx] ^ $sect;  ## sections are decimal here
        $flips += $_ for split //, $xored;
    }
    
    return $flips;   
}

use Test::More;

is(minflips(3, "101100101"), 1, 'ex-1');
is(minflips(4, "10110111"),  2, 'ex-2');

is(minflips(3, "110001011101010"), 6, '5 sections');
is(minflips(3, "110001011101010111001010101010010000111101111110"), 21, 'many sections');
is(minflips(3, "000000"), 0, 'no work done - 0s');
is(minflips(2, "010101"), 0, 'no work done - mixed');

is(minflips(2, "0101010"), undef, 'not divisible');


done_testing();


