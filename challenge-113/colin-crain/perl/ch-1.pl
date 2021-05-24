#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       represent.pl
#
#       Represent Integer
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N and a digit $D.
# 
#         Write a script to check if $N can be represented as a sum of positive
#         integers having $D at least once. If check passes print 1 otherwise 0.
# 
#         Example
# 
#             Input: $N = 25, $D = 7
#             Output: 0 
#                 as there are 2 numbers between 1 and 25 
#                 having the digit 7 i.e. 7 and 17. 
#                 If we add up both we don't get 25.
# 
#             Input: $N = 24, $D = 7
#             Output: 1
# 
#         method:
#             Ok this is just weird. There are two completely different parts to
#             this puzzle that tie together to create an answer. As for "why?" I
#             have no response. I'm not entirely sure this even qualifies as
#             number theory. On the other hand, I love the nonsensical
#             relationship: "All multiples of seven or thirteen that rhyme with
#             the color blue". Very postmodern mix-and-match. Actually I may be
#             on to something there. Perhaps I should flush that out and give it
#             to Mohammad. In any case maybe some insights will clear some of
#             that up, but for now I think the plan is to jump right in. It's
#             certainly not boring, that's for sure. 
#             
#             The first part of the puzzle, the valid options for assembly, is
#             rather cryptic as laid out, but this is made clearer in the
#             example: "...having $D [a digit] at least once" evidently means
#             the number is represented, in base-10, by a digit-string
#             containing the given value in at least one of its positions. This
#             will be the only numbers available to combine to reach the target.
# 
# 
#             To evaluate all the various combinations for the second part of
#             the task we will need a comprehensive list of available
#             candidates. Constructing this list is a nice little
#             puzzle-within-a-puzzle.
# 
#             Mathematically this subtask is a bit of a mess, which makes it
#             lucky for us to have `grep` available. We can examine each value
#             less than our target with a regular expression and filter only
#             those that match the digit.
# 
#             Once we have our number list, we need to start trying
#             combinations.
# 
#             special cases:
# 
#             Q: is a single value a sum? If so then every number that already
#             contains the digit can be verified by itself. We'll have to think
#             about this. We could justify a "no" by reasoning that as 0 is not
#             positive this excludes summing with 0, and if we define summing as
#             a repeated associative binary operation this would preclude single
#             digit sums. That's easy, if a bit arbitrary. On the other hand the
#             identity is the most fundimental axiom in mathematics. The sum is
#             a total quantity, so of course it equals itself. I can see this
#             both ways. 
# 
#             Q: what about the digit 0? For the digit 0 we should exclude
#             leading 0s or every number is validated. Leading 0s are always
#             there and never there, full of sound and fury signifying nothing.
#             Only in these concrete forms of positional number theory do we
#             need to even consider such things. 
# 
#             Q: what about the digit 1? Every number can be constructed from a
#             sequence of some number of 1s so for the digit 1 we should
#             immediately return 1. We can extend this logic to state any number
#             evenly divisible by the digit can be immediately validiated. 
#             
#             Filtering for at least 1 specific digit does not seriously reduce
#             the pool of candidates for large numbers, with the number of
#             options converging upwards towards the entire set. Thus as the
#             numbers get larger the number of possible solutions more closely
#             resembles the integer compositions, which is 2^(n-1) arrangements.
#             We can conclude that no matter what we do, this is going to blow
#             up exponentially. The best we can do is try and be efficient and
#             see how far we get. 
# 
#             This certainly sounds right, except...
# 
#             Where’s the kaboom? There was supposed to be an earth-shattering
#             kaboom!
# 
#             Ok, now we're getting into the number theory! Let's think it 
#             through. There are only 10 digits to consider.
# 
#             We've already looked at 1, which can be used to construct any
#             number, and noted that numbers with the digit as a divisor will
#             all validate. Now let's consider the digit 2.
# 
#             One half the whole number set is even, and will validate. Working
#             upewards from 1 we get all numbers constructed with the digit:
#             {2,12,21,22,23,...}. Note that 21 is the first odd number. Any odd
#             number greater than 21, minus 21 will yield an even number that
#             can be constructed by some number of 2s, and hence validate.
# 
#             Now we're getting somewhere. Can we generalize this? Yes we can.
#             Any digit n can be used to construct a range of numbers {n0,n1,n2,
#             ... ,n9}. This provides a sequence of numbers that can be selected
#             from to produce a difference with any last digit desired in a
#             subtraction from a larger value. 
# 
#             Every single digit is contained within the range 
# 
#                 (0,1,2, ... ,10)
# 
#             and it follows that every digit will have at least one multiple
#             within any arbitrary range 
# 
#                 (k0,k1,k2, ... ,k9) ∀ k 
# 
#             Thus we can conclude that for any number constructed as nn or
#             higher there exists some value within the range 
# 
#                 kx | x ∈ {0,1,2,...,9}
#                 
#             that can be subtracted to produce a multiple of n.
# 
#             The only remaining case is 0, which follows the pattern, albeit slightly
#             adapted, when considered as 10. This has the the range 
# 
#                 (100,101,102, ...,109)
# 
#             The value, constructed 10n + n, is a lower bound beyond which all
#             numbers will validate for a given digit n. If we allow a number to
#             validate itself, the entire range of 10n + k numbers is included, so
#             the lower bound drops to 10n. In actuality these bounds are
#             sometimes less, as we see from experiment:
# 
#             Actual lower bounds, by numeric analysis:
# 
#             digit     allow self      no not allow
#             ------    ----------      ------------
#                 1	    	1	        	2
#                 2	    	20	        	22
#                 3	    	21	        	24
#                 4	    	40	        	44
#                 5	    	50	        	55
#                 6	    	60	        	66
#                 7	    	61	        	68
#                 8	    	80	        	88
#                 9	    	81	        	90
#                 0	    	100	        	110
# 
#             In our solution, we could short-circuit when the target exceeds 
# 
#                 (10 * $digit + $digit)
# 
#             but presenting the numeric breakdown found is more interesting so
#             we do that instead. If we needed to filter really large numbers
#             with a 1/0 result this would certainly be the way to go, as for
#             large targets the recursion can go quite deep. A `prefilter()`
#             function implementing this is included, but not tied in. 

#             The only effort made here is to determine whether any solution
#             exists, not to qualify those solutions, so the solutions found
#             favor smaller numbers over large and can quite lenghty repetitions
#             of the examnined digit rather than a single multiple. Again
#             matters of efficiency would be entirely side-stepped by
#             short-circuiting out of any values above the relevent lower bound.
#             If efficiency was at a premium the results, being so closely
#             bounded, could be reduced to one or more lookup tables. They
#             wouldn't even be very big. But again, this output would be boring
#             so we won't do that.
# 
#             The decision on whether to exclude the number itself in potential
#             summing, disallowing a one-digit valid sum, is configurable by
#             appending any positive number to the input. A positive value
#             excludes the number from consideration.
# 
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
no warnings qw( recursion );
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

@ARGV = (55, 7, 1) if @ARGV == 0;

my ($target, $digit, $exclude_self) = @ARGV;

my @num = grep {/$digit/} (1..$target-($exclude_self > 0));

my $sol = sum_from_list( $target, \@num );
say "Target: $target";
say "Digit:  $digit";

if (defined $sol) {
    say "Output: 1";
    say ((join " + ", $sol->@*), " = $target"); 
}
else {
    say "Output: 0";
}

sub sum_from_list ($target, $numlist, $partsum = 0, $partial = []) {
    for my $nextval ( $numlist->@* ) {
        if ($partsum + $nextval == $target) {
            push $partial->@*, $nextval;
            return $partial;
        }
        my @newpart  = ( $partial->@*, $nextval );
        my $newpsum = $partsum + $nextval;
        my @newlist  = grep { $_ >= $nextval && $_ <= $target - $newpsum} $numlist->@*;
        next if scalar @newlist == 0;
        my $sol = sum_from_list ($target, \@newlist, $newpsum, \@newpart);
        return $sol if defined $sol;
    }
    return undef;
}


sub prefilter ($target, $digit) {
    return $target >= 10 * $digit + $digit;
}
