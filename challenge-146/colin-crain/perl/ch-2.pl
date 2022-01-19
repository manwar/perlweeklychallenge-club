#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       curiously-arboreal.pl
#
#       Curious Fraction Tree
#         Submitted by: Mohammad S Anwar
#         Consider the following Curious Fraction Tree:
# 
# 
#                       ┏━━━━━━━━━━━━┫1/1┣━━━━━━━━━━━━┓               
#                       ┃                             ┃               
#               ┏━━━━┫1/2┣━━━━┓                 ┏━━━━┫2/1┣━━━━┓       
#               ┃             ┃                 ┃             ┃       
#           ┏┫1/3┣┓         ┏┫3/2┣┓         ┏┫2/3┣┓         ┏┫3/1┣┓   
#           ┃     ┃         ┃     ┃         ┃     ┃         ┃     ┃   
#        ┃1/4┃   ┃4/3┃   ┃3/5┃   ┃5/2┃   ┃2/5┃   ┃5/3┃   ┃3/4┃   ┃4/1┃
# 
#                          (A Curious Fraction Tree)
# 
# 
#         You are given a fraction, member of the tree created similar to the above sample.
# 
#         Write a script to find out the parent and grandparent of the given member.
# 
#         Example 1:
#             Input: $member = '3/5';
#             Output: parent = '3/2' and grandparent = '1/2'
#         Example 2:
#             Input: $member = '4/3';
#             Output: parent = '1/3' and grandparent = '1/2'


#         analysis:
#         
#             Oooh, a proper puzzle! Mystery! Intrigue! Suspense!
# 
#             What's going on here? Welll we notice first the numbers
#             involved are getting larger as we descend, sometimes in the
#             numerator, sometimes the denominator. But going down the left
#             hand side we can plainly see 1,2,3 and the 4. This suggests a
#             progression from top to bottom. Further playing around reveals
#             the larger number in the child node is the sum of the
#             components of the parent: 1 + 1 = 2, 1 + 3 = 4, 3 + 2 = 5.
# 
#             The next deduction is that the left child is, with respect to
#             the parent values, the numerator over the sum, and the right is
#             the sum over the denominator.
# 
#             The next row would thus start:
# 
#             1/5, 5/4,   4/7, 7/3,   3/8, 8/5,   5/7, 7/2,   2/7, 7/5,   5/8, 8/3 ...
# 
#             Curiouser and curiouser.
# 
#             Now when given one of these values what are we to do? How can
#             we run the machine in reverse?
# 
#             Can we assume we are limited to positive numbers for a moment?
#             The use of the word "similar" in the description suggests we
#             might in a broader sense use differing starting values, but I'm
#             going to understand things as meaning that in a the tree shown,
#             extended using the same rules of construction. In that case is
#             can easily seen that the numbers always increase as more nodes
#             are added. The values are another thing to study, but the
#             numbers used above and below the fraction line are always going
#             to go up, and so will always be positive.
# 
#             The left child is the numerator over that value plus some other
#             positive value, so the numerator will always be less than the
#             denominator. Likewise, the same logic can be reversed and
#             applied to the right side to conclude that for those nodes the
#             numerator will always be greater.
# 
#             So from this, when given a fraction, say 7/5, we can determine
#             that it is a right child, as 7 is greater than 5.
# 
#             So far so good. In fact, 7 isn't just greater than 5, it's 2
#             greater than 5. Now a right side child is the sum of the
#             parents over the denominator, so 5 is the parent denominator,
#             which means 2 must be the numerator. The parent is thus 2/5.
# 
#             Ok let's keep going. Now, of course, 5, the denominator, is
#             greater than 2, indicating this is a left-hand child. This
#             allows us to explore the other case. In a left child, the
#             parent numerator is over the sum. So for the parent of 2/5, the
#             numerator is 2 and the sum is 5, making the denominator 3. So
#             the parent is 2/3.
# 
#             Thus the parent of 7/5 is 2/5, and the grandparent is 2/3.
#             Applying a left rule followed by a right says the next parents
#             up the chain are 2/1 and 1/1, which we can see from the diagram
#             is the case.
# 
#             Neat.
# 
#           method:
# 
#             Based on whether the numerator is greater than the denominator,
#             we will select one of two courses of action, for a left child
#             or a right.
# 
#                 * For the left-child parent the numerator will continue to
#                 be the numerator, and the new denominator the denominator
#                 minus the numerator.
# 
#                 * For the right-child parent the numerator will be the
#                 numerator minus the denominator, and the denominator will
#                 remain unchanged.
# 
#           post-analysis:
# 
#             It appears that most fractions are found somewhere on the tree.
#             Looping and ascending until we find 1/1 usualy finds its way
#             home, but not in every case. 105/1452 (some arbitrary mid-sized
#             numbers) degenerates into 0/3 without passing go. So its
#             unclear what exactly the rules are governing which values are
#             part of the 1/1 root and which are not, and if not, where they
#             end up. 

#             Curiouser still. What an unusual tree. 

#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $input = shift // '101/1452';

my ($num, $den) = $input =~ /(\d+)\/(\d+)/;
say "input $num/$den";

my @parent = get_parent( $num, $den);
say "parent      is ", join '/', @parent;
say "grandparent is ", join '/', get_parent( @parent );

my $count = 0;
while ( 1 ) {
    my @prev = @parent;
    @parent = get_parent( @parent );
    if ( $parent[0] == $prev[0] and $parent[1] == $prev[1] ) {
        say "--> repeats";
        last;
    }
    last if $parent[0] ==  1 and $parent[1] ==  1 ;
    say "--> next upwards is ", join '/', get_parent( @parent );
}


sub get_parent ( $num, $den ) {
    return ( $num < $den ) 
        ? ( $num, $den - $num )     ## left child
        : ( $num - $den, $den ) ;   ## right child
}



