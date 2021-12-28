#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       ulam.pl
#
#       Ulam Sequence
#         Submitted by: Mohammad S Anwar
# 
#         You are given two positive numbers, $u and $v.
# 
#         Write a script to generate Ulam Sequence having at least 10 Ulam
#         numbers where $u and $v are the first 2 Ulam numbers.
# 
#         For more information about Ulam Sequence, please checkout the website.
# 
#         The standard Ulam sequence (the (1, 2)-Ulam sequence) starts with
#         U1 = 1 and U2 = 2. Then for n > 2, U(n) is defined to be the
#         smallest integer that is the sum of two distinct earlier terms in
#         exactly one way and larger than all earlier terms.
# 
#         Example 1
# 
#             Input: $u = 1, $v = 2
#             Output: 1, 2, 3, 4, 6, 8, 11, 13, 16, 18
# 
#         Example 2
# 
#             Input: $u = 2, $v = 3
#             Output: 2, 3, 5, 7, 8, 9, 13, 14, 18, 19
# 
#         Example 3
# 
#             Input: $u = 2, $v = 5
#             Output: 2, 5, 7, 9, 11, 12, 13, 15, 19, 23
# 
#         method:
#             the tricky part here is making sure that the given number can
#             be summed in only one unique manner from two other distinct
#             ulam numbers. To do this we will require a database of sums,
#             and every time we add a number to the sequence we will need to
#             produce a new list of sums of that value and every other
#             previously produced. This list represents a unique construction
#             for each value, and these values are updated into the database,
#             with duplicate entries incrementing a counter of possible
#             formations.
# 
#             The database is thus a lookup of sums mapped to the number of
#             constructions that can be used to create the value.
# 
#             To find the next Ulam number we need to find the smallest value
#             from this lookup of sums that has only one construction. We do
#             this by sorting the keys to the lookup and trying the smallest
#             values first. If a candidate has more than one constuction is
#             is rejected and the next is tried until the first unique value
#             is found.
# 
#             We constrain the growth of trying every Ulam number with
#             every other, keeping and then sorting those results to find
#             the smallest, by culling sums less than the last calculated
#             Ulam number from the lookup and only adding new sums greater
#             than the last calculated as well. Also, as new candidates are
#             tried if they are rejected they are removed from the database
#             as we go. In fact, we don't even need to sort the whole
#             database of sums at all, as hashtable lookups are very
#             efficient and Ulam numbers are close together. We can just
#             try the next number until we get a candidate, which is then
#             dealt with as before.
# 
            
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $u   = shift // 17;
my $v   = shift // 13;
my $len = shift // 10000;

( $u, $v ) = ( $v, $u ) if $v < $u;

my $sums = { ($u + $v) => 1 };
my @ulam = ( $u , $v );

get_next_ulam( $sums, \@ulam ) for 1..$len;

say $_ for @ulam;


### subs all the way down


sub get_next_ulam ( $sums, $ulam ) {

    my $candidate = $ulam->[-1];

    while ( $candidate++ ) {
        next    if not exists $sums->{$candidate};
        last    if $sums->{$candidate} == 1;
        delete  $sums->{$candidate} ;      
    }

    for my $u ( @ulam ) {
        $sums->{ $u + $candidate }++ if $u + $candidate > $ulam[-1];
    } 

    push $ulam->@*, $candidate;
}




