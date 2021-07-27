#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       trip-from-the-line.pl
#
#       Basketball Points
#         Submitted by: Mohammad S Anwar
#         You are given a score $S.
# 
#         You can win basketball points e.g. 1 point, 2 points and 3 points.
# 
#         Write a script to find out the different ways you can score $S.
# 
#         Example
# 
#         Input: $S = 4
#         Output: 1 1 1 1
#                 1 1 2
#                 1 2 1
#                 1 3
#                 2 1 1
#                 2 2
#                 3 1
# 
#         Input: $S = 5
#         Output: 1 1 1 1 1
#                 1 1 1 2
#                 1 1 2 1
#                 1 1 3
#                 1 2 1 1
#                 1 2 2
#                 1 3 1
#                 2 1 1 1
#                 2 1 2
#                 2 2 1
#                 2 3
#                 3 1 1
#                 3 2
# 
#             method: 
#                 what we have here is an integer partition problem, of sorts,
#                 where we only allow the partitions the maximum value of 3. The
#                 way I thought up to do this, out on a walk, was to start with
#                 an empty list of lists, and add lists of partial partitions to
#                 it as long as the sum was less than the final score. We would
#                 work through this list, shifting off the next partial from one
#                 end, adding either a new 1, 2 or 3 to the end of it and if the
#                 new instance still summed less than the total, pushing it on
#                 the backside of the queue to come around again. If the sum
#                 came out exact, we have a parition and that list is moved over to 
#                 another list for solutions and not recycled.
# 
#                 The first time around I put in a clause, that a new number
#                 cannot be less than the last number placed: this avoids
#                 repetitions by keeping the new patterns ordered, and we wont
#                 get both [1, 2, 1, 2] and [2, 1, 2, 1].
# 
#                 After I got this up and running I realized that what was being
#                 requested in fact wanted these repetitions counted as separate
#                 variations. So be it; this only involved stripping out a
#                 single `grep` filtering the `@points` options, so at each
#                 juncture the full gamut of adding a new 1, 2 or 3 was
#                 considered. 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw( sum );

my $score = shift @ARGV // 5 ;      ## default value

my @points = ( 1, 2, 3 );

my @queue = map { [$_] } grep { $_ <= $score } (1..3);
my @parts;

while ( my $seq = shift @queue ) {
    for my $next (  @points ) {
        my $sum = sum $seq->@*, $next;
        if ( $sum <= $score ) {
            $sum == $score ? push @parts, [$seq->@*, $next]
                           : push @queue, [$seq->@*, $next] ;
        }
    }
}

say "$_->@*" for @parts;


