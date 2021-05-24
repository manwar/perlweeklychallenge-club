#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       one-two-up-we-go.pl
#
#         Climb Stairs
#         Submitted by: Mohammad S Anwar
#         You are given $n steps to climb
# 
#         Write a script to find out the distinct ways to climb to the top. You
#         are allowed to climb either 1 or 2 steps at a time.
# 
#         Example
# 
#             Input:  $n = 3
#             Output: 3
# 
#                 Option 1: 1 step  + 1 step
#                 Option 2: 1 step  + 2 steps
#                 Option 3: 2 steps + 1 step
# 
#             Input:  $n = 4
#             Output: 5
# 
#                 Option 1: 1 step  + 1 step  + 1 step  + 1 step
#                 Option 2: 1 step  + 1 step  + 2 steps
#                 Option 3: 2 steps + 1 step  + 1 step
#                 Option 4: 1 step  + 2 steps + 1 step
#                 Option 5: 2 steps + 2 steps
# 
#         method
#             This was a fun one to think through. The first step involved 
#             looking at the results for input 5 in the examples as ordered sets 
#             of elements summed together:
#             
#             (1+1+1+1), (1+1+2), (2+1+1), (1+2+1), (2+2)
#             
#             What this looks like are integer compositions of the input value,
#             with the added constraint that the maximum value is 2. A little
#             thinking-through validates this, as we want every combination of 1
#             and 2 that adds up to the correct number of steps. We're going to
#             ignore the possibility of launching yourself off into space from
#             the next-to-last step as though there were two to jump up, even
#             though one could probably land it and not break your neck.
#             Pretending there is more than one remaining step does not make it
#             so. The sum must be exact. 
#             
#             Further analysis with a pencil and paper:
#             
#             input       compositions        C_2(n)
#             1           1                   1
#             2           1,1                 2
#                         2
#             3           1,1,1               3
#                         2,1
#                         1,2
#             4           1,1,1,1             5
#                         2,1,1
#                         1,2,1
#                         1,1,2
#                         2,2
#             5           1,1,1,1,1           8
#                         2,1,1,1
#                         1,2,1,1
#                         1,1,2,1
#                         2,2,1          __________ change here from 1 to 2
#                         1,1,1,2       
#                         2,1,2
#                         1,2,2
#             6           1,1,1,1,1,1         13
#                         2,1,1,1,1
#                         1,2,1,1,1
#                         1,1,2,1,1
#                         2,2,1,1
#                         1,1,1,2,1
#                         2,1,2,1
#                         1,2,2,1        __________ change here from 1 to 2
#                         1,1,1,1,2              
#                         2,1,1,2
#                         1,2,1,2
#                         1,1,2,2
#                         2,2,2
# 
#             And yes, although I didn't include it here, the compositions,
#             enumerated, for the next term are 21.
#                         
#             So wait one cotton-picking minute — is that the Fibonacci
#             sequence? And if so, why?
# 
#             Yes it is, and if you notice I've rearranged the sets to more
#             clearly show the association: separate each composition part into
#             a head and a tail, with the tail the last value. Now look at the
#             head, and notice it is repeated in the set for a previous value.
#             I've sorted things in each sequence entry so all the parts ending
#             in 1 are followed by those ending in 2.
# 
#             There are only two available values for a member of a composition
#             part: 1 and 2. Thus each part in a composition for a new number
#             will be that of a previously calculated composition with either 1
#             or 2 added. To make the sums correct, the previous compositions
#             referenced will be those for C(n-1), plus an additional 1, and
#             C(n-2), with an additional 2.
# 
#             Every composition set for a given value is already an exhaustive
#             enumeration of possible arrangements for that number.
# 
#             So to propagate every part of the composition set for the previous
#             value, we add the new element, 1 or 2, to the end to create a new
#             part. It can be seen that any other placement of the new item will
#             produce a duplication that will need to be removed, for although
#             different ordering of the elements produces different parts, the
#             parts counted are unique. This is the fundimantal difference
#             between partitions and compositions, that the order of the
#             elements matters.
# 
#             So for every number in the sequence we have a set of composition
#             parts created from the immediately previous number with 1, and the
#             second previous with 2. In other words, 
#             
#             C(n) = C(n-1) + C(n-2)
#             
#             which is the Fibonacci recurrence relation. With 
#             
#             C(1) = 1
#             C(2) = 2
#             
#             the recurrence follows, setting the base pattern. Further, these values are
#             themselves part of the Fibonacci sequence. So in other words:
#             
#             C(n) = F(n+1) ∀ n > 0
# 
#             So we'll make a memoized Fibonacci generator to calculate our
#             values and call it a day. Good work lads, pack it in. 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use Lingua::EN::Inflexion;


use Memoize;
memoize qw( fib );

sub fib ($n) {
    return $n if $n < 2;
    return fib($n-1) + fib($n-2);
}


for (1..21) {   
    my $str = inflect("<#d:$_>For $_ <N:steps> there <V:is> ");
    $str .= fib($_+1) . ' ';
    $str .= inflect("<#d:$_>possible <N:ways> to climb <N:them>.");
    say $str; 
}

