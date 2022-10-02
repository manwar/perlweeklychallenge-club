#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       serial-box.pl
#
#
#       Sequence Number
#         Submitted by: Mohammad S Anwar
#         You are given list of strings in the format aa9999 i.e. first 2
#         characters can be anything 'a-z' followed by 4 digits '0-9'.
# 
#         Write a script to replace the first two characters with sequence
#         starting with '00', '01', '02' etc.
# 
#         Example 1
#             Input: @list = ( 'ab1234', 'cd5678', 'ef1342')
#             Output: ('001234', '015678', '021342')
# 
#         Example 2
#             Input: @list = ( 'pq1122', 'rs3334')
#             Output: ('001122', '013334')
# 
#       contextual dissertation
# 
#         I suppose you could typify me as a "big picture" sort of
#         problem-solver. In my experience, problems are often
#         misidentified, so when asked to perform some cryptic task, it is
#         common for my first response to ask: "Why? What are we trying to
#         achieve here?"
# 
#         Because of the systematic manner my brain works in, I can
#         sometimes see clearly that the given solution either solves the
#         wrong problem or creates unexpected collatoral damage that makes
#         it unworkable. Properly identifying the goal, and from that the
#         right path to the goal, and from that identifying the necessary
#         steps required to navigate the path — this works, in general.
#         Starting with the problem, on the other hand, often leads to
#         force-fitting the goal into the solution instead of the other way
#         around. And what we end up with is an elaborately
#         well-thought-out process that doesn't do what we need.
# 
#         Yea, that sucks. Then we end up redefining the objectives and
#         pretend that's what we wanted to do all along. Which can be fine,
#         sometimes (Really! Sometimes that randomness leasd to cool stuff
#         you didn't plan on doing. You need to be flexible!), but the
#         thing is after all that we still haven't done what needed to be
#         done in the first place. So we're back to square one. 
# 
#       method
# 
#         So what, may I ask, are we trying to do here? The task is
#         straightforward, but are we mapping letter combinations to
#         numeric prefaces, or just tossing out the alphabetic data and
#         replacing it with a serial nubering system that records the order
#         the data was presented to us in?
# 
#         Without a larger context it's not possible to say. In the former
#         case, should the letter perfix "ab" arise again we would reuse
#         the numeric prefix "00" we already assigned to it. In the latter
#         case we're just throwing out data forever which is always a red
#         flag for me. Are we sure we want to do that?
# 
#         The two examples are alphabetically sequential, but stated to
#         contain any values, and the prefixes used do not in fact repeat.
#         So there's no clarity forthcoming from there. One more note is
#         that given a two-letter prefix where the letters "can be
#         anything" there are 26 x 26 ordered combinations available, or
#         676 possible prefixes. We are asked to provide a two-number
#         serial code to the numeric portion of each element. Should that
#         really be a three-number code to allow a bijective mapping
#         between letter prefixes and numbers? Again we are in the dark. 
# 
#         Without any additional information I see no better option than to
#         solve the problem as stated, removing the alphabetic prefix and
#         substituting two-digit a serial number prefix. Hope that's right.
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

say join ' ', serialize( 'ab1234', 'cd5678', 'ef1342' );

sub serialize ( @input ) {
    my $i = 0; 
    my @out = map { sprintf "%02d%s", $i++, substr $_, 2 } @input;

    return @out;
}


