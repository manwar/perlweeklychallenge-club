#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       room-for-one-more.pl
#
#         Good Triplets
#         Submitted by: Mohammad S Anwar
# 
#         You are given an array of integers, @array and three integers $x,$y,$z.
# 
#         Write a script to find out total Good Triplets in the given array.
# 
#         A triplet array[i], array[j], array[k] is good if it satisfies
#         the following conditions:
# 
#             a) 0 <= i < j < k <= n (size of given array)
#             b) abs(array[i] - array[j]) <= x
#             c) abs(array[j] - array[k]) <= y
#             d) abs(array[i] - array[k]) <= z
# 
#         Example 1
#             Input : @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
#             Output: 4
# 
#             Good Triplets are as below:
#             (3,0,1) where (i=0, j=1, k=2)
#             (3,0,1) where (i=0, j=1, k=3)
#             (3,1,1) where (i=0, j=2, k=3)
#             (0,1,1) where (i=1, j=2, k=3)
# 
#         Example 2
#             Input : @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
#             Output: 0
# 
# 
# 
#         Analysis and Observations
# 
#             For the second version of our challenge, now in 3-D, the rule
#             changes don't allow a simple counting, so three nested loops
#             it is. However each nesting only adds the logarithm of the
#             earlier complexity so things don't really balloon much at
#             all. The counting solution was more cleverness than anything,
#             althoug of course it is more efficient which, given the small
#             effort applied, is always worth it.
# 
#             With the addition of arbitrary coefficients I do think we've
#             lost the plot somehow on the subject of a pure, inherent,
#             simple and graceful goodness, descending into a morally
#             relativistic swamp of subjective rationalizations.
# 
#             Hail Satan indeed.
# 
#             If it feels good, do it, baby.
# 
#         Method
# 
#             We are given a list and a set of constraits, and need to find
#             out all possible triplets that satisfy our criteria. The way
#             to do that, it appears, is to look through the possiblities
#             and check them. Fortuantely the indexes of any valid output
#             sequence must be in ascending order, so out search space is
#             drastically limited from the set of all possible permutation
#             3-element sublists.
# 
#             Instead we can look at possible first indexes, then select
#             from those indices following the first, and then from those
#             that follow the second. This give us O n(log n)(log(log n))
#             complexity.
# 
#             I think. It makes my brain hurt and I'm in a hurry.
# 
#             We make three loops and check the values we find, with a
#             counter to tally our valid sequences. Let's get to it.
#         
#         
#         
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


my ($x, $y, $z, @list) =  @ARGV;
say count_trips($x, $y, $z, \@list) if @list;


sub count_trips ( $x, $y, $z, $arr ) {
    my $count = 0;
    
    for my $i ( 0..$arr->$#*-2 ) {
        for my $j ( $i+1..$arr->$#*-1 ) {
            for my $k ( $j+1..$arr->$#* ) {
                $count++ if 
                        abs($arr->[$i]-$arr->[$j]) <= $x 
                    and abs($arr->[$j]-$arr->[$k]) <= $y
                    and abs($arr->[$i]-$arr->[$k]) <= $z ;
            }
        }
    }
    return $count;
}




use Test::More;

is count_trips( 7,2,3, [3,0,1,1,9,7] ),     4, 'ex-1';
is count_trips( 0,0,1, [1,1,2,2,3] ),       0, 'ex-2';
is count_trips( 7,2,3, [3] ),               0, 'bad input - short list';
is count_trips( 7,2,3, [] ),                0, 'bad input - no list';

done_testing();
