#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       dont-get-too-friendly.pl
#
#       Two Friendly
#         Submitted by: Mohammad S Anwar
# 
#         You are given 2 positive numbers, $m and $n.
# 
#         Write a script to find out if the given two numbers are Two Friendly.
# 
#         Two positive numbers, m and n are two friendly when gcd(m, n) = 2
#         ^ p where p > 0. The greatest common divisor (gcd) of a set of
#         numbers is the largest positive number that divides all the
#         numbers in the set without remainder.
# 
#         Example 1
# 
#             Input:  $m = 8, $n = 24
#             Output: 1
# 
#             Reason: gcd(8,24) = 8 => 2 ^ 3
# 
#         Example 2
# 
#             Input:  $m = 26, $n = 39
#             Output: 0
# 
#             Reason: gcd(26,39) = 13
# 
#         Example 3
# 
#             Input:  $m = 4, $n = 10
#             Output: 1
# 
#             Reason: gcd(4,10) = 2 => 2 ^ 1

#             METHOD:

#                 Being nice is nice. I strive for it every day — it makes
#                 my day better, as seemingly that of those around me, and
#                 generally the world is a better place with more kindness
#                 in it. In some circumstances, though, niceness may
#                 express an inappropriate level of informality to an
#                 otherwise serious situation. Telling jokes at a funeral,
#                 for instance, or discussing the attractiveness of a Judge
#                 at court, are examples of transgressing these unwritten
#                 boundaries.
# 
#                 Such social cues are commonly referred to as "reading the
#                 room". Not all actions, however well meaning, are
#                 appropriate in all situations, and the rules governing
#                 this behavior are difficult to codify, often relying on
#                 non-verbal communication to transmit information on the
#                 correct level of informality to act with among a social
#                 group at a specific time. This social interaction is
#                 learned behavior and subject to change between specific
#                 contexts even among the same individuals. Informality
#                 leads to more relaxed interactions, with generally
#                 positive outcomes, and is hence desirable. Fortunately
#                 informality itself generally leads to a softening of the
#                 rules for interation, causing the social tensions set up
#                 by the rules of formailty to self-dissipate as
#                 familiarity rises. We can sidestep the complexity by
#                 actually becoming friends, which provides a nice escape.
# 
#                 Failure to accurately navigate the mores of interpersonal
#                 behavior within a group can lead to social awkwardness
#                 when conventional patterns are broken; this is known as a
#                 faux pas, or literally, misstep.
# 
#                 This is often realized when the subject expresses
#                 excessive affection and informality towards either a
#                 member of the opposite sex or a heirachical superior,
#                 seeming to reference a social or emotional commonality
#                 that has not yet formed between the parties.
# 
#                 This conduct is likely to form a repulsive
#                 counter-reaction from the object party, in an effort to
#                 clarify the situation, which, again subject to the rules
#                 of acceptible social mores, may be largely unspoken, such
#                 as a lack of response ot turning away without engagement.
#                 Failure at this point to "read the room" indicates a lack
#                 of social awareness that touches the core of the social
#                 contract and will near-universally produce a sense of
#                 unease in the object of the unwanted informality. This is
#                 sometimes even expressed physically, through the
#                 activation by the amygdala of the sympathetic nervous
#                 system, as a tingling of the skin, or one's hair standing
#                 up, often said on the back of the neck. These are real
#                 physical manifestations of the fight-or-flight response,
#                 brought on by the unpredictabity of the subject's
#                 behavior.
# 
#                 This behavior, of acting outside the range of
#                 predictabilty withing the socal contract, is referred to
#                 as "creepy".
# 
#                 Being too friendly, before such interactions are socially
#                 confirmed, is creepy.
# 
#                 Don't be creepy.
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub is_creepy ( $m, $n ) {
## is $m too friendly towards $n? Does it need to BTFO? Boundaries, people!
    ( $m, $n ) = ( $n, $m % $n ) while $n > 0;      ## gcd
    $m /= 2 until $m % 2;                           ## power of 2?
    return $m == 1 ? 1 : 0;
}



## some extra, relevant functions that we don't actually use directly, 
## as their required functionality is inlined in is_creepy()
sub gcd ( $m, $n ) {
    ( $m, $n ) = ( $n, $m % $n ) while $n > 0;
    return $m;
}

sub power_of_2_div ( $num ) {
    $num /= 2 until $num % 2;
    return $num == 1 ? 1 : 0;
}

sub power_of_2_log ( $num ) {
    return ((log($n) / log(2)) =~ /\./ ? 0 : 1);
}

sub power_of_2_popcount ( $num ) {
    use List::Util qw(sum);
    sum( split //, sprintf "%b", $num ) == 1 ? 1 : 0;
}





say "\n\n";

use Test::More;

is is_creepy( 8, 24 ),  1,  'ex-1';
is is_creepy( 26, 39 ), 0,  'ex-2';
is is_creepy( 4, 10 ),  1,  'ex-3';

is is_creepy( 60, 70 ), 0,  'test-1';

done_testing();
