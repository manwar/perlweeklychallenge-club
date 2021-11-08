#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       time-out-of-joint.pl
#
#         Disjoint Sets
#         Submitted by: Mohammad S Anwar
#         You are given two sets with unique integers.
# 
#         Write a script to figure out if they are disjoint.
# 
#         The two sets are disjoint if they don’t have any common members.
# 
#         Example
#             Input: @S1 = (1, 2, 5, 3, 4)
#                    @S2 = (4, 6, 7, 8, 9)
#             Output: 0 as the given two sets have common member 4.
#     
#             Input: @S1 = (1, 3, 5, 7, 9)
#                    @S2 = (0, 2, 4, 6, 8)
#             Output: 1 as the given two sets do not have common member.

#         method:
# 
#             when we say "Set" what we mean here in Perl is an array of
#             unique elements. They could be numbers, but as we're going to
#             stringify them in the end really most anything that can be a
#             hash key will will do.
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


my @S1 = (1, 2, 5, 3, 4);
my @S2 = (4, 6, 7, 8, 9);

say disjoint(\@S1, \@S2);



sub disjoint ($s1, $s2) {
    my %sethash = map { $_ => undef } $s1->@*;

    for my $member ( @S2 ) {
        return 0 if exists $sethash{"$member"};
    }   
    return 1;
}




