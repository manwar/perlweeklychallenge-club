#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       wiggling-out-of-trouble.pl
#
#         Wiggle Sort
#         Submitted by: Mohammad S Anwar
#         You are given a list of integers, @list.
# 
#         Write a script to perform Wiggle Sort on the given list.
# 
# 
#         Wiggle sort would be such as 
#         list[0] < list[1] > list[2] < list[3]….
# 
# 
#         Example 1
#             Input: @list = (1,5,1,1,6,4)
#             Output: (1,6,1,5,1,4)
# 
#         Example 2
#             Input: @list = (1,3,2,2,3,1)
#             Output: (2,3,1,3,1,2)
# 
# 
#         method
#         
#         What is a wiggle sort? Beyond the immediate series of
#         conditionals that need apply the actual final sequencing seems
#         prety undefined. For example, there are a number of valid
#         solutions for the first example in addition to the one given,
#         such as (1,4,1,5,1,6) and (1,5,1,4,1,6). In fact there are six,
#         and no method is defined to select a single solution.
# 
#         Further, from the same example multiple occurances of a value are
#         obviously allowed, but no provision is made for when no valid
#         wiggle ordering can be made. Consider, for instance, a list
#         (2,2,2,2,2). We can plainly see that as no value is greater than
#         any other no solution exists that will satisfy the very first
#         conditional we come across: the second element must be greater
#         than the first.
# 
#         I believe if the values were unique we could determine there
#         would exist at minimum one solution for every array. But this is
#         not the case, determining whether an array is solvable at all is
#         not obvious. Can we narrow this down?
# 
#         If more than ceiling(length/2) elements are the same we will run
#         out of elements to alternate and be forced into a run of adjacent
#         equal values, so that won't work. It might be true that any array
#         satisfying this condition can be made to work.
# 
#         1,1,1,0,0 cannot work because 0,1,0,1,1 is the only progression
#         going from left to right and it fails at the last element.
#         
#         1,1,1,0,2   ->  no solution, starting from either 0 or 1
#         1,1,1,2,2   ->  1,2,1,2,1 as the over-half multiple is the smallest 
#         1,1,2,0,0   ->  1,2,0,1,0 or 0,1,0,2,1 
#         1,1,2,2,0   ->  1,2,0,2,1 or 0,2,1,2,0
#         
#         how about 6?
#         
#         1,2,2,2,3,4 ->  2,3,2,4,1,2     two above, one below
#         1,1,2,2,2,4 ->  2,4,1,2,1,2     one above, two below
#         4,4,4,2,2,1 ->  1,4,2,4,2,4     all below
#         
#         it seems the multiple count of a single value can only be larger
#         than floor(length/2) if it is the smallest value, but can be up
#         to and including half the elements placed anywhere. I believe
#         this logic applies downwards as well, meaning divisions smaller
#         than one-half can all be accomodated.
# 
#         I believe, then, if we have no element count over one-half the
#         total elements, or if the count of the most numerous element is
#         ceiling(length/2) and the value in question is the smallest
#         value, then that exists a valid solution.
# 
#         Note the ceiling will only apply when there are an odd number of
#         elements, and we will start with the multiple and alternate the
#         other, higher values in any ordering to create a valid
#         wigglesort. This is obviously an edge case.
# 
#         Multiple elements need to be separated, so if we sort the arrant
#         and divide it into two halves we can pick alternately from either
#         the head or tail from both halves we can create wigglesorts if we
#         are consistent with our choice. This sequential action of
#         alternately taking the same indexed elements from two arrays is
#         sometimes called zipping.
# 
#         We can still get into trouble with an overlapping multiple in the
#         middle. This will determine whether we zip from the head or the
#         tail. 
#         
#         Consider (1,2,3,4,2,2,5,2):
#         
#         Sorted and split we get:
#         (1,2,2,2) and (2,3,4,5)     
#         
#             head -> (1,2), (2,3), (2,4), (2,5)  does not work
#             tail -> (2,5), (2,4), (2,3), (1,2)  works
#         
#         So if the multiple in the lower half is more than half that
#         subarray length we will need to start in reverse from the tails,
#         otherwise we can use the heads.
# 
#         Finally, though, in hindsight why even do this last step? There's
#         nothing inherent in the idea of a wigglesort that the result is
#         lexicographically ascending, or even coherent. There's no reason
#         to go from low to high. The problem in the edge case I
#         constructed is that a run of multiples in the middle can overlap
#         if we start from the heads of the subarray halves. Selecting from
#         the tail first separates the overlap, moving the interfering
#         values towards the ends, away from each other. 
# 
#         So why not do this always and just be done with it? No particular
#         wigglesort is better than any other. So lets do that. Out with
#         the `no_duplicates()` sub and ant attemot to sort from the heads.
#         This tightens things up rather well. And our `zip()` subroutine
#         might as well be rolled into its `wigglezip()` wrapper. 
# 
#         I get the feeling some important information was left out of this
#         description. But I feel this should give us a satisfactory
#         algorithm for finding one valid solution for every array that can
#         have one.
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

my @input = @ARGV
    ? @ARGV
    : (6,4,4,7,4,4,1,8,5,4);
say "input:  @input";
    
@input    = sort {$a<=>$b} @input;
my @small = @input[0..(@input+1)/2-1];              ## up to ceiling
my @large = @input[(@input+1)/2..@input-1];         ## rest of array

unless ( has_solution(\@input) ) {
    say "no solution possible" and exit;
}
say "sorted: ", join ' ', wigglezip( \@small, \@large )->@*;

sub has_solution ( $arr ) {
## checks to see no element is duplicated more than one-half the total
## length, or the ceiling under the specific circumstance that it is the 
## smallest value in the set
    my %freq;
    $freq{$_}++ for $arr->@*;
    my @range = sort {$b<=>$a} values %freq;      
    return 1 if $range[0] <= scalar($arr->@* )/ 2;   ## highest freq value
    if ($range[0] == int( ($arr->@* + 1)/2 )) {     ## ceiling
        my ($multiple) = grep { $freq{$_} == $range[0] } keys %freq;
        if ( min( keys %freq ) == $multiple ) {
            return 1;
        }
    }   
    
    return 0;
}

sub wigglezip ($aref1, $aref2) {
## zip two arrays from head if this makes a valid wigglesort, else reverse
## the arrays and zip, resulting with a zip from tails backwards    
    my @low  = reverse $aref1->@*;
    my @high = reverse $aref2->@*;
    my @zipped;
    
    for (0..$#low) {
        push @zipped, $low[$_];
        push @zipped, $high[$_] unless $_ > $#high; ;
    }
    
    return \@zipped;  
}

# sub zip ($aref1, $aref2) {
# ## nondestructively zip two array references, if array are unequal length
# ## first is longer 
#     my @zipped;
#     for (0..$aref1->$#*) {
#         push @zipped, $aref1->[$_];
#         push @zipped, $aref2->[$_] unless $_ > $aref2->$#* ;
#     }
#     return \@zipped;
# }

# sub no_duplicates ($arr) {
# ## check to see if an array does not contain any adjacent duplicated values
# ## in sequence
# #     say "last |$arr->@*| ", scalar $arr->@*;
#     for (0...($arr->$#*-1)) {
# #         say "idx $_";
#         return 0 if $arr->[$_] == $arr->[$_+1];
#     }
#     return 1;
# }
