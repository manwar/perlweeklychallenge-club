#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       degrees-of-difficulty.pl
# 
#       Array Degree
#         Submitted by: Mohammad S Anwar
#         You are given an array of 2 or more non-negative integers.
# 
#         Write a script to find out the smallest slice, i.e. contiguous
#         subarray of the original array, having the degree of the given
#         array.
# 
#         The degree of an array is the maximum frequency of an element in the array.
# 
#         Example 1
#             Input: @array = (1, 3, 3, 2)
#             Output: (3, 3)
# 
#             The degree of the given array is 2.
#             The possible subarrays having the degree 2 are as below:
#                 (3, 3)
#                 (1, 3, 3)
#                 (3, 3, 2)
#                 (1, 3, 3, 2)
# 
#             And the smallest of all is (3, 3).
# 
#         Example 2
#             Input: @array = (1, 2, 1, 3)
#             Output: (1, 2, 1)
# 
#         Example 3
#             Input: @array = (1, 3, 2, 1, 2)
#             Output: (2, 1, 2)
# 
#         Example 4
#             Input: @array = (1, 1, 2, 3, 2)
#             Output: (1, 1)
# 
#         Example 5
#             Input: @array = (2, 1, 2, 1, 1)
#             Output: (1, 2, 1, 1)
#
#       analysis:

#         Right off the bat, we could solve this by starting at the first
#         index, and creating a slice with the second and determining the
#         degree. Then extend the slice one position and try again. Keeping
#         the initial 2-length slice as the running maximum, we replace it
#         under two possible conditions: if the degree is *higher* than the
#         current maximum, or if the degree is the same and the length is
#         shorter. Eventually when we exhaust all slices we will have
#         captured the shortest slice of the highest degree. As-is we will
#         find the first of multiple otherwise-equal options. If we change
#         the second criterium to "less than or equal to" we will capture
#         the last occurence.
# 
#         This is all well and good but isn't very efficient, as we need to
#         examine every possible slice before making a determination. On
#         the other hand we do avoid having to precompute the degree of the
#         array beforehand. But this is small solace against our quadratic
#         complexity.
# 
#         What do we gain if we do precompute the degree? Well, for one we
#         can stop extending a slice once we have reached it. There's no
#         point in adding additional elements when we know the next number
#         will never be our target, as that would have the effect of
#         raising the degree. This is a good line of thinking.
# 
#         So from this we can infer that the last element in a slice will be
#         that number that raises the slice to the proper degree. Once we
#         have that any additional numbers will simple add length, and the
#         slice will be the shortest it can be. 
# 
#         Or is it?
# 
#         The same logic can be extended to the *first* incidence of what
#         we will call the degree-number. Any elements before that will also
#         merely extend the slice, adding length to no good end. If we
#         could somehow cull these elements — everything before the first
#         incidence then we would have properly minimized the slice.
# 
#         It appears we can infer that the shortest slice will begin with
#         the degree-number and also end with it. Very interesting.
# 
#         When we initially determine the degree we can note the character
#         with the highest frequency, or characters if there are more than
#         one with equal counts. Then, when iterating across the elements,
#         if the slice does not start with one of those numbers we can jump
#         to the next position. Then, we extend the slice until we have
#         counted the correct number of occurences. This soounds much more
#         efficient!
# 
#         But wait, don't say yes yet, there's more! When we first make our
#         pass over the array we can gather more information when we go,
#         namely the first occurence and last occurence of a number. The
#         once we find the number or numbers that define the degree we will
#         already know the slice boundaries that start and end with these
#         numbers, and the length will be in the span between the two,
#         inclusive. The shortest span wins!
#       
#       method:

#         We will make a single pass over the input array, hashing the
#         data three ways: incrementing a frequency counter, logging the
#         position to the last-sighting hash, and, onlyif it has never been
#         seen before, logging its position in the initial-occurence hash.
#         While we're at it we can keep a running tab on the maximum
#         degree.
# 
#         When we finish the pass, We can make a list of numbers that yield
#         the degree with a grep filter. Then, for each of these we can
#         construct a new hash key in a fourth hash that points to the
#         computed length, keeping a tally of the minimum value as we go. A
#         second filter based on this minimum will give us our minimal
#         degree-numbers, and we can then output the slices defined by the
#         low and high bounds we've previously gathered.
# 
        
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



sub degree_slice ( @arr ) {
    my (%bag, %first, %last);
    my $max = 0;
    for (0..$#arr) {
        ++$bag{   $arr[$_] } > $max and $max = $bag{$arr[$_]};
        $first{ $arr[$_] } = $_ if not defined $first{$arr[$_]};
        $last{  $arr[$_] } = $_;
    }

    my @deg_int = grep { $bag{$_} == $max } keys %bag;
    my $min = @arr;
    my %lengths;
    
    for (0..$#deg_int) {
        $lengths{ $deg_int[$_] } = $last{ $deg_int[$_] } - $first{ $deg_int[$_] } + 1;
        $min > $lengths{ $deg_int[$_] } and $min = $lengths{ $deg_int[$_] };
    }
    my @minimum_degree_integers = grep { $lengths{ $_ } == $min } @deg_int;

    say "input:  @arr";
    say "degree: $max";
    say "minimal slice(s):";
    for (@minimum_degree_integers) {
        my @slice = @arr[ $first{$_} .. $last{$_} ];
        say "   @slice";
    }
}



## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## TESTS

my @tests = (
    [1, 3, 3, 2],
    [1, 2, 1, 3],
    [1, 3, 2, 1, 2],
    [1, 1, 2, 3, 2],
    [2, 1, 2, 1, 1],
    [1, 2, 3, 4, 5],
    [1, 1, 2, 1, 2, 2]
);

for (@tests) {
    degree_slice($_->@*);
    say '';
}
