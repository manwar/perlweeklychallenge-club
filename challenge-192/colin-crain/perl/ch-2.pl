#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       liberté-égalité-fraternité.pl
#
#       Equal Distribution
#         Submitted by: Mohammad S Anwar
#         You are given a list of integers greater than or equal to zero,
#         @list.
# 
#         Write a script to distribute the number so that each members are
#         same. If you succeed then print the total moves otherwise print
#         -1.
# 
#         Please follow the rules (as suggested by Neils van Dijke
#         [2022-11-21 13:00]
# 
#         1) You can only move a value of '1' per move
#         2) You are only allowed to move a value of '1' to a direct
#            neighbor/adjacent cell
# 
#         Example 1:    
#             Input: @list = (1, 0, 5)
#             Output: 4
#     
#             Move #1: 1, 1, 4
#             (2nd cell gets 1 from the 3rd cell)
#     
#             Move #2: 1, 2, 3
#             (2nd cell gets 1 from the 3rd cell)
#     
#             Move #3: 2, 1, 3
#             (1st cell get 1 from the 2nd cell)
#     
#             Move #4: 2, 2, 2
#             (2nd cell gets 1 from the 3rd cell)
#     
#         Example 2:
#             Input: @list = (0, 2, 0)
#             Output: -1
#     
#             It is not possible to make each same.
# 
#         Example 3:   
#             Input: @list = (0, 3, 0)
#             Output: 2
#     
#             Move #1: 1, 2, 0
#             (1st cell gets 1 from the 2nd cell)
#     
#             Move #2: 1, 1, 1
#             (3rd cell gets 1 from the 2nd cell)

#             analysis:
# 
#             What a curious puzzle! essentailly a model of diffusion, we
#             wish to take an irregular field of data and progressively
#             smooth it until we obtain a continuous lowest-energy state.
#             Only instead of operating on all points simultaniously, we
#             make one ajustement at a time in discrete steps of one unit.
# 
#             In diffusion, differeneces between a local state and its
#             neighbors are distributed between the two, raising the value
#             of one and lowering the other. Should the values be the same
#             there is no reasonto change anything. With fields in real
#             space this is an application of the calculus, but here in our
#             simplified, stepwise model we don't need the complexity that
#             entails. Instead we need an algorithm that locates the next
#             best difference between two adjacent values and adjusts the
#             higher to the lower. Exactly what that means remains to be
#             determined. 

#             It seems the first thing to do is make sure a general
#             integral leveling is even possible. If the sum of all values
#             is not evenly divisible by the number of pockets there's no
#             point in continuing. If it is, then this is our target value.
# 
#             The rules do not expressly demand we do the leveling as
#             quickly as possible, so we'll worry about optimization after
#             we've come up with any way to accomplish our goal at all. And
#             again we are back to performing the best move over and over
#             until we get there.
# 
#             What would the best move be? It seems moving the maximal
#             value one position in the direction of the minimum would be a
#             good strategy. Let's implement that. WHat's the worst thing
#             that could possibly happen? 
# 
#         method:
#             
#             Starting small, we'll need functions to determine the minimum
#             and maximum values within the array, and the positions where
#             thay are located. This will involve iterating across the
#             array and keeping a running tally. In theory this looping
#             could be collected into a single combined function, but for
#             clarity we'll keep the actions clearly deliniated. The
#             maximum counts upward from negative infinity, the minimum
#             down from infinity. These tallies too could be started from
#             the value for the first index but I find the special string
#             for infinity underused and conceptually robust. So why not? 
# 
#             Next we will need a move action. Given a position to more
#             from and a position to move towards, this function will just
#             change the array in-place instead of returning and rewriting
#             the array variable. This too seems conceptually pure. Less
#             copying, just change the thing itself.
# 
#             Finally arriving at the meat of the matter, the solve
#             function takes the array and decides whether or not there is
#             a solution using modular division. After calculating an
#             initial minimum and maximum the process is handed to a loop,
#             moving one value at a time and recalculating the leftmost min
#             and max until the two values are equal.
# 
#             As it works out we don't actually need the target value after
#             all. A counter keeps track of the number of cycles through
#             the loop, counting the applications of the move function.
#             Because I found the movements fasinating, I left in a VERBOSE
#             switch to detail the individual moves as they are made. 
# 
#             Because the algortihm identifies the largest difference
#             between elements in the system and their relative placements,
#             and then moves to equalize the discrepancy from high to low
#             in the direction found, it should always terminate if an
#             equal state exists. Because it does not care about absolute
#             values, it works for any whole number input. As there is no
#             cause for backtracking, the resulting solution should use the
#             minimum number of moves. 
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

use constant VERBOSE => 1;



sub max_pos ( @array ) {
## returns position and value of maximum element values
## leftmost value is returned in case of multiple occurences
    my ($max, $pos) = ( "-Inf", 0 );
    for (0..$#array) {
        if ($array[$_] > $max) {
            ($max, $pos) = ($array[$_], $_);
        }
    }
    return ($max, $pos);
}

sub min_pos ( @array ) {
## returns position and value of minimum element values
## leftmost value is returned in case of multiple occurences
    my ($min, $pos) = ( "Inf", 0 );
    for (0..$#array) {
        if ($array[$_] < $min) {
            ($min, $pos) = ($array[$_], $_);
        };
    }
    return ($min, $pos);
}

sub move ( $maxpos, $minpos, $arr ) {
## alters the array in-place via reference
    $arr->[$maxpos]--;
    $maxpos > $minpos 
        ? $arr->[$maxpos-1]++
        : $arr->[$maxpos+1]++ ;
}

sub solve ( @array ) {
    ## first check to see it's possible
    my $sum;
    $sum += $_ for @array;
    return -1 if $sum % @array;

    ## set the stage 
    my ($max, $maxpos) = max_pos ( @array );
    my ($min, $minpos) = min_pos ( @array );
    VERBOSE and say "@array     max $max min $min";
    
    my $moves;
    
    ## move values by 1 until lowest state
    while ( $max > $min and ++$moves ) {
        move( $maxpos, $minpos, \@array );
        ($max, $maxpos) = max_pos ( @array );
        ($min, $minpos) = min_pos ( @array );
        VERBOSE and say "@array     max $max min $min";
    }
    return $moves;
}



## input and processing
my @array = @ARGV;
@array == 0 and @array = (10, -5, 15, -6, 0, 4);



## report
my $res = solve( @array );
VERBOSE or say $res and exit;

$res > -1 
    ? say "solved in ", $res, "\n"
    : say "no solution\n";

say "input :  @array";
say "output:  $res";


