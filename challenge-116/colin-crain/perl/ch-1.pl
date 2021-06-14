#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       sequet-number.pl
#
#         Number Sequence
#         Submitted by: Mohammad S Anwar
#         You are given a number $N >= 10.
# 
#         Write a script to split the given number such that 
#         the difference between two consecutive numbers is 
#         always 1 and it shouldn’t have leading 0.
# 
#         Print the given number if it impossible to split the number.
# 
#         Example
#         
#             Input : $N = 1234
#             Output: 1,2,3,4
# 
#             Input : $N = 91011
#             Output: 9,10,11
# 
#             Input : $N = 10203
#             Output: 10203 as it is impossible to split satisfying the conditions.
#             
#         method:
#          cases: 9991000 -> 999, 1000    additional digit length
#                 565     -> 5, 6, 5      up and down
#                 
#          foreach number segment length 1..number length/2
#          remove substr seg-num from copy
#             foreach seg-num + 1, seg-num - 1
#                 get length, look at substr that length
#                     doen it match inc value?
#                     if yes recurse
# 
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

my $num =  $ARGV[0] || '';
   $num += 0;
my $out;

my $ceil = length($num) - int(length($num)/2);
for my $group (1..$ceil) {
    if ($out = match_next_segment($num, 0, $group)) {
        say join ',', $out->@*;
        exit;
    }
}
say $num;

sub match_next_segment ($num, $start = 0, $len = 1, $part = []) {
    my $seg = substr $num, $start, $len;
    return if $seg eq '-';
    my @part = ($part->@*, $seg);
    return \@part if $start+$len == length $num;
    for my $next ( $seg+1, $seg-1 ) {
        my $len2 = length $next;
        if ( substr($num, $start+$len, $len2) == $next ) {
            my $sol = match_next_segment($num, $start+$len, $len2, \@part);
            return $sol if defined $sol;
        }        
    }
    return undef;
}




