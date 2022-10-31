#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       magick-powers.pl
#
#       Magical Triplets
#         Submitted by: Mohammad S Anwar
# 
#         You are given a list of positive numbers, @n, having at least 3
#         numbers.
# 
#         Write a script to find the triplets (a, b, c) from the given list
#         that satisfies the following rules.
# 
#         1. a + b > c
#         2. b + c > a
#         3. a + c > b
#         4. a + b + c is maximum.

#         In case you end up with more than one triplets having the
#         maximum, then pick the triplet where a >= b >= c.
# 
#         Example 1
#             Input: @n = (1, 2, 3, 2);
#             Output: (3, 2, 2)
# 
#         Example 2
#             Input: @n = (1, 3, 2);
#             Output: ()
# 
#         Example 3
#             Input: @n = (1, 1, 2, 3);
#             Output: ()
# 
#         Example 4
#             Input: @n = (2, 4, 3);
#             Output: (4, 3, 2)
# 
# 
#         method: 
#             Hard to understand the problem here, but we seem to want
#             triples of elements from the input list, selected unordered
#             but distinctly. As this will yield six possible variations in
#             ordering for any final pick, there will always be multiple
#             maximums to chose from if we investigate all groupings. So
#             because of this  we will sort the triples as we add them to
#             the list of final candidates.
# 
#             This list is again sorted for the maimum sum, with secondary
#             sorting on first the value of a, then b, then c. This is not
#             exactly specified but seems to fit the bill. Without studing
#             the triples first it's difficult to conceptualise a
#             counterexample. It seems the simple a >= b >= c ordering is
#             potentially insufficient on its own to isolate a single
#             candidate so I've decided on this plan as always delivering a
#             single, unique ordered triple. Because logic and math. 
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

use Algorithm::Combinatorics qw( variations );


sub get_triplet ( $arr ) {
    my @trips;
    
    my $iter = variations( $arr, 3);   ## array value 3-permutations (aka variations)
    while ( my $v = $iter->next ) {
        next unless $v->[0] >= $v->[1] >= $v->[2];
        push @trips, $v if is_triplet( $v->@* );
    }

    ## pretty sure this is what's requested:
    ##      -> largest total sum
    ##          -> larger a
    ##              -> larger b
    ##                  -> larger c (logically unnecessary so removed)
    
    @trips = sort { $a->[0] + $a->[1] + $a->[2] <=> $b->[0] + $b->[1] + $b->[2] 
                    || $a->[0] <=> $b->[0] 
                    || $a->[1] <=> $b->[0] } @trips;
                    
    return pop @trips;
    
}


sub is_triplet ( $a, $b, $c ) {
    ($a + $b > $c) and ($b + $c > $a) and ($a + $b > $c) ? 1 : 0;
}


# my $out = get_triplet([1, 1, 2, 3]);
my $out;

my @tests = ( [1, 2, 3, 2], [1, 3, 2], [1, 1, 2, 3], [2, 4, 3] );

for ( @tests ) {
    local $" = ', ';
    say "input:  ($_->@*)";
    defined ($out = get_triplet( $_ ))
        ? say "output: ($out->@*)"
        : say "output: ()" ;
    say '';
}


