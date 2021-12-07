#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       octosplitter.pl
#
#       Number Divisors
#         Submitted by: Mohammad S Anwar
#         Write a script to find lowest 10 positive integers having exactly 8
#         divisors.
# 
#         Example
#         24 is the first such number having exactly 8 divisors.
#         1, 2, 3, 4, 6, 8, 12 and 24.
# 
#         method: 
#             determining a progressive group of factor sets that will
#             produce the lowest integers with only 8 factors is...
#             complex. We'll settle for complex.
# 
#             It's hardly obvious, and it seems that the first thing to do,
#             should we want to study the sets and see if we can draw some
#             inferances, is to find the solutions and have a look.
# 
#             This of course brings us full circle and solves our problem
#             by... solving our problem. Of course. Why didn't I think of
#             that before? 
# 
#             In any case we can always try every number from 2 up to half
#             the target, and add on 1 and the target, as apparently we're
#             including those this time. Fair enough. By extension we also
#             include the number itself. Note we aren't being asked for
#             *prime* factors, so for example should the case arrive both 2
#             and 4 should be counted, so we need to try every value in the
#             range.
#             
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




sub nd_brute ( $num, @div ) {
    $num % $_ or push @div, $_ for 2..$num/2 ;    
    return 1, @div, $num;
}

say "number     divisors";
say "----------------------------------------";
my ($test, $count) = (0,0);
while ( $count < 9 ) {
    my @facts = nd_brute( ++$test );
    if (@facts == 8) {
        say "$test      ", sprintf "%4d" x 8 , @facts ;
        $count++;
    };
}








# use Test::More;
# 
# is 
# 
# done_testing();
