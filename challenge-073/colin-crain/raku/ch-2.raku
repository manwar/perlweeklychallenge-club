#!/usr/bin/env perl6
# 
#
#       smallest_smaller_neighbor.raku
#
#         TASK #2 › Smallest (Smaller) Neighbour
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers @A.
# 
#         Write a script to create an array that represents the
#         smallest element to the left of each corresponding
#         index. If none found then use 0.
# 
#         Example 1
#         Input: @A = (7, 8, 3, 12, 10)
#         Output: (0, 7, 0, 3, 3)
# 
#         For index 0, the smallest number to the left of $A[0]      
#             is none, so we put 0.
#         For index 1, the smallest number to the left of $A[1] 
#             in (7), is 7 so we put 7.
#         For index 2, the smallest number to the left of $A[2] 
#             in (7, 8) is none, so we put 0.
#         For index 3, the smallest number to the left of $A[3] 
#             in (7, 8, 3) is 3, so we put 3.
#         For index 4, the smallest number to the left of $A[4] 
#             is (7, 8, 3, 12) is 3, so we put 3 again.
# 
#         Example 2
#         Input: @A = (4, 6, 5)
#         Output: (0, 4, 4)
# 
#         For index 0, the smallest number to the left of $A[0] 
#             is none, so we put 0.
#         For index 1, the smallest number to the left of $A[1] 
#             in (4) is 4, so we put 4.
#         For index 2, the smallest number to the left of $A[2] 
#             in (4, 6) is 4, so we put 4 again.
#
#       method:
# 
#         smallest neighbor is a confusing title, as we are not
#         looking for the smallest element to the left of a
#         given index, but rather the smallest element to the
#         left of the index that is smaller than that at the index.
#
#         “triangular comma” produces a list of lists, each with
#         one more element of the original array appended. Which,
#         incidentally, is exactly what we need. Well almost,
#         because each element is a list, rather than an array.
#         By coercing it as such before we hand it off to our
#         smallest_neighbor() sub we can then pop off the
#         rightmost value and compute the output from there,
#         using min and a comparison check to see whether the
#         value of the minimum is less than the last element.
# 
#         As 0 is a real value that is right in the middle of
#         the potential range (as negative values are not
#         disallowed), using it to label a target miss could be
#         a bit confusing. With that in mind I have taken the
#         liberty to substitute the null set sign '∅',
#         which looks a lot like '0' in my preferred font, but
#         isn't, as it makes understanding what's happening
#         just a little bit easier. 

        
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

my @input = 7, 8, 3, 12, 10;
my @output;

for [\,] @input  {                            ## triangular comma 
    push @output, smallest_neighbor( $_.Array );     # $_ is List
}

sub smallest_neighbor( @slice ) {
## find the minimum value to the left of last value not inclusive
## return it if less than last, else ∅
    my $val = @slice.pop;
    my $min = @slice.min;
    $min < $val ?? $min !! '∅';
}

@input .say;
@output.say;



