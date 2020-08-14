#! /opt/local/bin/perl
#
#       smallest_smaller_neighbor.pl
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
#         method:
#         smallest neighbor is a confusing title, as we are not
#         looking for the smallest element to the left of a
#         given index, but rather the smallest element to the
#         left of the index that is smaller than that element.
#         Or stated another way, the minimum item of the slice
#         A[0..$i-1] that is less than A[$i]. When we put it
#         like that the challenge really resembles the
#         previous, only the size of the window is dynamic and
#         there is some additional comparison going on. But the
#         process is very similar: iterate acrosss the field,
#         selecting a slice for each index, and determine the
#         minimum value within that slice. Instead of just
#         taking the minimum value, though, in the case we can
#         add some additional processing in the function
#         called.
# 
#         As there are never any elements to the left of index
#         0, the first digit will always be 0 and hence can be
#         inserted from the get-go. After that, starting at
#         index 1, the slice from 0 to the current index is
#         passed to our smallest_neighbor function, where the
#         indexed value immediately popped off the end. The
#         minimum of the remaining slice is found, and if that
#         value is less than the index value it is returned,
#         else 0. There is no need to make more than one pass
#         over the list, as the minimum will be the minimum no
#         matter its value.
# 
#         As 0 is a real value that is right in the middle of
#         the potential range (as negative values are not
#         disallowed), using it to label a target miss could be
#         a bit confusing. With that in mind i have taken the
#         liberty to substitute the null set sign '∅' instead,
#         which looks a lot like '0' in my preferred font, but
#         isn't, as it makes understanding what's happening
#         just a little bit easier.
# 
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @input = @ARGV;
@input = (7, 8, -3, 12, -10);
my @output = ('∅');

for (1..@input-1) {
    my @slice = @input[0..$_];
    my $smallest = smallest_neighbor( @slice );
    push @output, $smallest;
}

say "Input:  @input";
say "Output: ", join ', ', @output;

## ## ## ## ## SUBS:

sub smallest_neighbor {
## find the minimum value to the left and return it if 
## min < given value, else 0
    my $value = pop @_;
    my $min = "inf";
    $_ < $min and $min = $_ for @_;
    $min < $value ? $min : '∅';
}