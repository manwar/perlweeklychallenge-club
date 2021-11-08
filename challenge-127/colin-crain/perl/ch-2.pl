#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       conflicts-over-time.pl
#
#       Conflict Intervals
#         Submitted by: Mohammad S Anwar
#         You are given a list of intervals.
# 
#         Write a script to find out if the current interval conflicts with any of the previous intervals.
# 
#         Example
#         Input: @Intervals = [ (1,4), (3,5), (6,8), (12, 13), (3,20) ]
#         Output: [ (3,5), (3,20) ]
# 
#             - The 1st interval (1,4) do not have any previous intervals to compare with, so skip it.
#             - The 2nd interval (3,5) does conflict with previous interval (1,4).
#             - The 3rd interval (6,8) do not conflicts with any of the previous intervals (1,4) and (3,5), so skip it.
#             - The 4th interval (12,13) again do not conflicts with any of the previous intervals (1,4), (3,5) and (6,8), so skip it.
#             - The 5th interval (3,20) conflicts with the first interval (1,4).
# 
#         Input: @Intervals = [ (3,4), (5,7), (6,9), (10, 12), (13,15) ]
#         Output: [ (6,9) ]
# 
#             - The 1st interval (3,4) do not have any previous intervals to compare with, so skip it.
#             - The 2nd interval (5,7) do not conflicts with the previous interval (3,4), so skip it.
#             - The 3rd interval (6,9) does conflict with one of the previous intervals (5,7).
#             - The 4th interval (10,12) do not conflicts with any of the previous intervals (3,4), (5,7) and (6,9), so skip it.
#             - The 5th interval (13,15) do not conflicts with any of the previous intervals (3,4), (5,7), (6,9) and (10,12), so skip it.
#
 #        method:
#             Although the examples seem to imply that the intervals are
#             perhaps sorted on their upper bound, a couple of points come
#             to mind. Starting from the first:

#                 1. Huh? 

#                 2. Is that really a way to sort intervals? The first
#                 value makes a little more sense, but part of the idea
#                 here is that some intervals will overlap others, so *by
#                 definition* either the first of second values will be out
#                 of order, depending on the method chosen.

#             
#             So we're going to punt and say the intervals will be assumed
#             to be in no particular order. This is the only thing that
#             makes any sense to me. The example ordering will be
#             considered coincidental.
# 
#             THis in turn means we will need to compare each element, as
#             it's processed, to every other perviously included element.
#             This will make the time complexity blow up, but we're not
#             going to worry about that.
# 
#             In the spirit of the Set Theory theme to tonight's
#             proceedings, we'll again consider the intervals as a set, and
#             as we add memebers to the set we'll check them against all of
#             the other members, but in this case the function will be more
#             complicated than a simple equality to determine a lack of
#             disjointness. Her ewe need to compare the enclosed spans.
#             This we can do with greater than and less than comparisons.
# 
#             There are a total of four ways that two intervals can
#             overlaps and conflict. Note I am not going to consider two
#             intervals sharing a point to be a conflict. For example the
#             time intervals four to eight and eight to ten do not
#             conflict, even though they share the boundary eight o'clock.
#             The point is considered infitesimal so there is no *overlap*,
#             which is the source of the conflict.
# 
#             But back to our four ways. Given intervals A and B each with
#             an upper and lower boundary:
#                 1. A-lower is inside B      (or B-upper is inside A)
#                 2. B-lower is inside A      (or A-upper is inside B)
#                 3. A surounds B completely  (or B is contained entirely within A)
#                 4. B surounds A completely  (or A is contained entirely within B)
#             
#             As you can see each definition is accompanied by
#             frame-reversal version, switching the names but describing
#             the same overlap. These are not considered different
#             conflicts, just different names for the same conflict. A
#             comparison using either reference frame will detect the one
#             of these conflicts.
# 
#             It turns out we only need three checks to cover all
#             possibilities. The Set interval is the existing set memeber
#             being compared to. 
#                 1. Set-upper > New-lower > Set-lower
#                 2. Set-upper > New-upper > Set-lower
#                 3. Set-lower > New-lower and New-upper > Set-upper

#             The third possibility is the new interval enveloping a set
#             member, and the fourth possibility, the new interval being
#             inside a set member, will already be detected by case 1 (and
#             case 2, if we don't short-circuit out).
# 
#             Note the frame reference is a bit arbitrary, but we do need
#             to consistently pick one or the other to make the three cases
#             work together with logical consistency to minimize the checks.
        
        
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my @input;
# @input = ( [1,4], [3,5], [6,8], [12, 13], [3,20]  );  ## ex-1
# @input = ( [3,4], [5,7], [6,9], [10, 12], [13,15] );  ## ex-2
@input = ( [1,4],  [5,20], [30,50], [25,60]);  

find_running_conflicts( @input );

sub find_running_conflicts ( @intervals ) {
    my %set;
    my @conflicts;
    
    for my $ivl ( @intervals ) {
        push @conflicts, $ivl if has_conflict( $ivl, \%set );
        $set{ join ':', $ivl->@* } = $ivl;
    }
    
    if (scalar @conflicts) {
        say "conflicts found:";
        say join ', ', 
            map { '[' . (join ',', $_->@*) . ']' } 
            @conflicts;
    }
    else {
        say "no conflicts";
    }

}

sub has_conflict ($ivl, $set) {
    my $si;
    for my $k (keys $set->%*) {
        $si = $set->{$k};
        if (     $si->[1]  > $ivl->[0] > $si->[0] 
            or   $si->[1]  > $ivl->[0] > $si->[0] ) {
               return 1;
        }
        if (     $si->[0]  > $ivl->[0] 
            and  $ivl->[1] > $si->[1] ) {
               return 1;
        }
    }
    return 0;
}












# use Test::More;
# 
# is 
# 
# done_testing();
