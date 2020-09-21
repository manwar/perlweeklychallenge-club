#! /opt/local/bin/perl
#
#       swing_to_the_left.pl
#
#         TASK #2 › Left Rotation
#         Submitted by: Mohammad S Anwar
#         You are given array @A containing positive numbers and @B containing
#         one or more indices from the array @A.
# 
#         Write a script to left rotate @A so that the number at the first index
#         of @B becomes the first element in the array. Similary, left rotate @A
#         again so that the number at the second index of @B becomes the first
#         element in the array.
# 
#         Example 1:
#             Input:
#                 @A = (10 20 30 40 50)
#                 @B = (3 4)
# 
#         Explanation:
#             a) We left rotate the 3rd index element (40) in the @A to make it 0th
#             index member in the array.
#                 [40 50 10 20 30]
# 
#             b) We left rotate the 4th index element (50) in the @A to make it 0th
#             index member in the array.
#                 [50 10 20 30 40]
# 
#         Output:
#             [40 50 10 20 30]
#             [50 10 20 30 40]
# 
#         Example 2:
# 
#         Input:
#             @A = (7 4 2 6 3)
#             @B = (1 3 4)
# 
#         Explanation:
#             a) We left rotate the 1st index element (4) in the @A to make it
#             0th index member in the array.
#                 [4 2 6 3 7]
# 
#             b) We left rotate the 3rd index element (6) in the @A to make it
#             0th index member in the array.
#                 [6 3 7 4 2]
# 
#             c) We left rotate the 4th index element (3) in the @A to make it
#             0th index member in the array.
#                 [3 7 4 2 6]
# 
#         Output:
#             [4 2 6 3 7]
#             [6 3 7 5 2]
#             [3 7 4 2 6]

#         ----------------------------------------
#
#         method:
#             I'm not sure "rotate" is exactly the right word for whats being
#             asked for here, but rather what we are being asked to do is to
#             produce the output as though the array had been rotated. The
#             distinction is important as we need to retain the integrety of the
#             original array and perform multiple transformations for output, as
#             the transformations are not consecutivly applied in a churning
#             fashion, but rather different applications to the atarting
#             sequence.
# 
#             The new sequences rearrange the elements such that the the tail of
#             the array, starting at the indicated element, becomes the head,
#             and the head, up to the break, becomes the tail. This can be done
#             easily with array slices.
# 
#             As removing the head element and placing it on the end is the act
#             of a left rotation, this is the same action moving a block of
#             elements simultaniously rather than individual elements
#             sequentially. In this sense it satisfies both the function and the
#             spirit of the challenge.
#             
# 
# 
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


my @array = (7, 4, 2, 6, 3);
my @idxs  = (1, 3, 0, 4);
my @output;
my $end = scalar @array - 1;

for my $idx (@idxs) {
    $idx == 0 and do {(push @output, \@array); next};
    my @shifted = @array[$idx..$end, 0..$idx-1];
    push @output,  \@shifted ;
}

say "array:      (", (join ', ', @array), ")";
say "index list: (", (join ', ', @idxs ), ")\n";

say "[", (join ' ', $_->@*), "]" for @output;










## ## ## ## ## SUBS:
