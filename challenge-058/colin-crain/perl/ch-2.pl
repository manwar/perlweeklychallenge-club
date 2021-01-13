#! /opt/local/bin/perl
#
#     law_and_order_lineup.pl
#
#       PWC 58 TASK #2 › Ordered Lineup
#         Reviewed by Ryan Thompson
#         Write a script to arrange people in a lineup according to how many
#         taller people are in front of each person in line. You are given two
#         arrays. @H is a list of unique heights, in any order. @T is a list of
#         how many taller people are to be put in front of the corresponding
#         person in @H. The output is the final ordering of people’s heights, or
#         an error if there is no solution.
#
#         Here is a small example:
#
#             @H = (2, 6, 4, 5, 1, 3) # Heights
#             @T = (1, 0, 2, 0, 1, 2) # Number of taller people in front
#
#         The ordering of both arrays lines up, so H[i] and T[i] refer to the same
#         person. For example, there are 2 taller people in front of the person
#         with height 4, and there is 1 person in front of the person with height
#         1.
#
#         As per the last diagram, your script would then output the ordering (5,
#         1, 2, 6, 3, 4) in this case. (The leftmost element is the “front” of the
#         array.)
#
#         Here’s a 64-person example, with answer provided:
#
#             # Heights
#             @H = (27, 21, 37,  4, 19, 52, 23, 64,  1,  7, 51, 17, 24, 50,  3,  2,
#                   34, 40, 47, 20,  8, 56, 14, 16, 42, 38, 62, 53, 31, 41, 55, 59,
#                   48, 12, 32, 61,  9, 60, 46, 26, 58, 25, 15, 36, 11, 44, 63, 28,
#                    5, 54, 10, 49, 57, 30, 29, 22, 35, 39, 45, 43, 18,  6, 13, 33);
#
#             # Number taller people in front
#             @T = ( 6, 41,  1, 49, 38, 12,  1,  0, 58, 47,  4, 17, 26,  1, 61, 12,
#                   29,  3,  4, 11, 45,  1, 32,  5,  9, 19,  1,  4, 28, 12,  2,  2,
#                   13, 18, 19,  3,  4,  1, 10, 16,  4,  3, 29,  5, 49,  1,  1, 24,
#                    2,  1, 38,  7,  7, 14, 35, 25,  0,  5,  4, 19, 10, 13,  4, 12);
#
#             # Expected answer
#             @A = (35, 23,  5, 64, 37,  9, 13, 25, 16, 44, 50, 40,  2, 27, 36,  6,
#                   18, 54, 20, 39, 56, 45, 12, 47, 17, 33, 55, 30, 26, 51, 42, 53,
#                   49, 41, 32, 15, 22, 60, 14, 46, 24, 59, 10, 28, 62, 38, 58, 63,
#                    8, 48,  4,  7, 31, 19, 61, 43, 57, 11,  1, 34, 21, 52, 29,  3);
#
#
#         method: I have to admit this one threw me for a loop for a while.
#             After taking the requisite time just to understand the challenge
#             posed, I at first became convinced the solution lay in some
#             reconfigured sort algorithm. Something involving selectively
#             swapping pairs of people in line and making successive passes over
#             the list until no more rearrangement was required. That sounded...
#             messy.
#
#             One thing was clear from the outset, that the first thing to do
#             would be to sort the people by height from tallest to shortest.
#             Since heights are defined to be unique, we can refer to
#             individuals by their height. To preserve synchronization with the
#             parallel array of people in front, it would be necessary to either
#             make matching moves of those indices too, or record the
#             association in a hash for future reference.
#
#             Once I had the people sorted by height, it became clear that if
#             the input required more people to be in front of a given person
#             than there were individuals taller than that person, the dataset
#             would not be solvable; that number, the people in front, directly
#             relates to the index of the person in the sorted line. In fact
#             they were the same.
#
#             Now we were getting somewhere. If the number of people required to
#             be in front was always less than or equal to the number of people
#             taller than that person, which in turn was that person's index in
#             the sorted line, then any movement of that person in the line to
#             the sorted position must be toward the front of the line in all
#             cases.
#
#             Furthermore, if people are only being moved in one direction,
#             towards the front, then the number of people taller than a person
#             in the line will never change, and the index of a given person
#             remains constant, as long as all rearragement of the line involves
#             people taller than themselves.
#
#             Therefore if we rearrange the people in line starting
#             with the tallest, proceding in descending order, upon arrival of a given
#             person's time to move, all people in front of that person will still be
#             taller, and that person will only need to move forward a number of
#             positions to leave the required number of taller people in front
#             of them. The starting number of people taller is the index of that
#             person, and any given person has a lookup of the required number
#             of taller people, so that person needs to move
#
#                 index - taller_than_lookup
#
#             spaces forward to the correct spot. But as the index of a person
#             does not alter by the rearrangements of any people before their given
#             turn, the final placement index of a person is determined by
#
#                 index - (index - taller_than_lookup)
#
#             which is simply the value of the taller_than_lookup.
#
#             What started seeming quite complex has turned out to be remarkably
#             simple: After preserving the association between heights and the
#             required number of taller people in front in a lookup, we sort the
#             line from tallest to shortest. Then we proceed down this line
#             starting with the tallest, moving each person in turn to the new
#             index determined by the lookup. That's it. When we have moved
#             every person we are done.
#
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

## @heights elems are unique
my @heights = (
    27, 21, 37,  4, 19, 52, 23, 64,  1,  7, 51, 17, 24, 50,  3,  2,
    34, 40, 47, 20,  8, 56, 14, 16, 42, 38, 62, 53, 31, 41, 55, 59,
    48, 12, 32, 61,  9, 60, 46, 26, 58, 25, 15, 36, 11, 44, 63, 28,
    5,  54, 10, 49, 57, 30, 29, 22, 35, 39, 45, 43, 18,  6, 13, 33
);

# Number taller people in front
my @taller_than = (
     6, 41,  1, 49, 38, 12,  1,  0, 58, 47,  4, 17, 26,  1, 61, 12,
    29,  3,  4, 11, 45,  1, 32,  5,  9, 19,  1,  4, 28, 12,  2,  2,
    13, 18, 19,  3,  4,  1, 10, 16,  4,  3, 29,  5, 49,  1,  1, 24,
     2,  1, 38,  7,  7, 14, 35, 25,  0,  5,  4, 19, 10, 13,  4, 12
);

my %in_front;

## load the parallel hashes with a hash slice
@in_front{@heights} = @taller_than;

my @ordered_lineup = sort {$b <=> $a} @heights;

## iterate through the indices
for my $idx (0..scalar(@heights) - 1) {

    ## if the sort requires more people in front than are in fact taller, the group cannot be sorted
    unless ($in_front{$ordered_lineup[$idx]} <= $idx) { die "there is no solution to this problem!"}

    ## find the position to reinsert the person
    my $insert_index = $in_front{$ordered_lineup[$idx]};
    next if $idx == $insert_index;                          ## nop and jump

    ## remove the person from this index and reinsert at the new index
    splice(@ordered_lineup, $insert_index, 0, ( splice(@ordered_lineup, $idx, 1) ) );
}

say join ', ', @ordered_lineup;


