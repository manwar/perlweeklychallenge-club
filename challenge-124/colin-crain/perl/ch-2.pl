#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Tug of War
#         Submitted by: Mohammad S Anwar
#         You are given a set of $n integers (n1, n2, n3, ….).
# 
#         Write a script to divide the set in two subsets of n/2 sizes each so
#         that the difference of the sum of two subsets is the least. If $n is
#         even then each subset must be of size $n/2 each. In case $n is odd
#         then one subset must be ($n-1)/2 and other must be ($n+1)/2.
# 
#         Example
# 
#             Input:        Set = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
#             Output:  Subset 1 = (30, 40, 60, 70, 80)
#                      Subset 2 = (10, 20, 50, 90, 100)
#     
#             Input:        Set = (10, -15, 20, 30, -25, 0, 5, 40, -5)
#                      Subset 1 = (30, 0, 5, -5)                        = 30
#                      Subset 2 = (10, -15, 20, -25, 40)                = 30
# 
#       method:
#         Did we do something like this already? In any case an algorithm
#         springs immediately to mind: sort the input, and distribute the two
#         largest values betwen the other lists. 

#         Yea, but negative values complicate that algorithm, especially when it
#         comes to making sure the divided parts are of equal-ish size. After
#         exploring that angle, I decided it was too complicated. So rather than
#         that, we're going to exhaustively compute the combinations n choose k
#         for half the elements, rounding down. Subtracting the sum of the
#         combination from the total sum of the list gives the fitness metric to
#         be minimized.
# 
#         Actually the difference of the part versus half the total will be the
#         same for the other half, so we can construct the metric by doubling
#         the partial sum and subtracting that, which is easier. We keep a
#         running minimum, keeping the difference between the segments and the
#         top-rated combination.
# 
#         At the end we need to create the complement segment, which we do by
#         finding the index of and then splicing out the elements in the
#         minimizing combination from the original inoput list. 
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use List::Util qw( sum first );
use Algorithm::Combinatorics qw( combinations );

my @input = sort { $a <=> $b } @ARGV > 0 
    ? @ARGV
    : (10, -15, 20, 30, -25, 0, 5, 40, -5);
    
die "must have more than 1 element in input array" if @input < 2;

my $sum = my $min = sum( @input );
my @part1;

my $half = int( @input/2 );
my $iter = combinations(\@input, $half);
while (my $c = $iter->next) {
    my $partial = sum $c->@*;
    if (abs($sum - 2 * $partial) < $min) {
        $min = abs($sum - 2 * $partial);
        @part1 = $c->@*;
    }
}

for my $target ( @part1 ) {
    splice @input, (first { $input[$_] == $target } (0..$#input)), 1;
}

my $output =
  (join ' + ', sort {$b<=>$a} @part1) . ' = ' . sum( @part1 ) . "\n" 
. (join ' + ', sort {$b<=>$a} @input) . ' = ' . sum( @input );

$output =~ s/\+ \-/- /g;

say $output;
