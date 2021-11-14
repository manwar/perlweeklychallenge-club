#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       a-series-of-lies.pl
#
#       Fibonacci Sequence
#         Submitted by: Mohammad S Anwar
#         You are given a positive number $n.
# 
#         Write a script to find how many different sequences you can
#         create using Fibonacci numbers where the sum of unique numbers in
#         each sequence are the same as the given number.
# 
#         Fibonacci Numbers: 1,2,3,5,8,13,21,34,55,89, …
# 
#         Example 1
#             Input:  $n = 16
#             Output: 4
#     
#             Reason: There are 2 possible sequences that can be created
#                     using Fibonacci numbers
#                       (3 + 13), (1 + 2 + 13), 
#                       (3 + 5 + 8) and (1 + 2 + 5 + 8)
# 
#         Example 2
#             Input:  $n = 9
#             Output: 2
#     
#             Reason: There are 2 possible sequences that can be created
#                     using Fibonacci numbers
#                       (1 + 3 + 5) and (1 + 8)
# 
#         Example 3
#             Input:  $n = 15
#             Output: 2
#     
#             Reason: There are 2 possible sequences that can be created
#                     using Fibonacci numbers             
#                       (2 + 5 + 8) and (2 + 13)

#         METHOD:

#             This is a very interesting challenge because individual Fibonacci numbers
#             can themselves be decomposed into a sequence of the previous two values,
#             which can further decomposed.
#             
#             The caveat to this recursive construction is the criterium that the 
#             elements of the sequence be unique. 
#             
#             Consider the number 34. This is itself a Fibonacci number so I see no reason 
#             not to assign it a sequence of one value, itself: (34)
#             
#             This value, 34, can be decomposed into the two previous values, according to 
#             the recursive relation that defines the sequence:
#             
#                 F(n) = F(n-1) + F(n-2)
#                 
#             Thus we add the sequence (13, 21).
#             
#             Now 21 cannot be immediately broken down because of a conflict with 13, so we will
#             start with that position:
#             
#                 (5, 8, 21) 
#                 
#             can be added, and the 5 can be broken down as well:
#                 
#                 (2, 3, 8, 21)
#                 
#             now the 8 cannot be broken down into (5, 3), nor the 21 into (8, 13) so we are done:
#             
#                 (34)
#                 (5, 8, 21)               
#                 (2, 3, 8, 21)
            
#             Well that's a mess, if I say so. I can see performing this
#             process through a sequence of recursive steps on a given
#             kernal solution, but how can we be sure that we have found
#             all solutions? How do we find our initial top-level solution,
#             and may there also, with larger numbers, be multiple
#             top-level solutions that each can be independantly 
#             deconstructed into their own solution sets?
# 
#             I think further study is necessary, and to to that we need a
#             more expansive base of targets and solutions to examine to
#             infer patterns. So we need a solver to perfect our solver,
#             which is problematic to say the least.
# 
#             Obviously we will need another approach.
# 
#             Another way to find solutions is to consider a list of all
#             unique Fibinacci numbers less less than or equal to the
#             target and try all combinations, keeping those that sum
#             correctly.
# 
#             It's a computationally-intensive way to go about things: for
#             a complete set of combinations from an input set, where each
#             element is either present or not, we double the solution
#             count for each new element, producting 2^n combinations for n
#             elements. It does, however, get the job done.
#             
#             I do feel number theory may reveal a procedure for easily producing 
#             top-level solution kernals that can be further reduced. I dare
#             say that logic is not obvious, though. I think for today we'll have to leave things there.
            


# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw(sum zip);

my $target = shift @ARGV || 1234;

my @fibs = (1,1);
my @sols;

sub generate_unique_fibs ( $limit ) {
## generates sequence of Fibonacci numbers up to and not greater than limit

    push @fibs, $fibs[-1]+$fibs[-2] while $fibs[-1]+$fibs[-2] <= $limit;
    shift @fibs;                                ## remove duplicate 1 at start
}

generate_unique_fibs( $target );
my $len = scalar @fibs;

say "input: ", $target, "\n";
say "found $len Fibonacci numbers less than $target";
say "there are ", 2 ** $len - 1, " combinations to be examined";
say "calculating...\n";

for my $num (1 .. 2 ** $len - 1) {
    my @bits = split //, sprintf "%0${len}b", $num;
    my @candidate = map { $_->[0] * $_->[1] } zip( \@fibs, \@bits);
    push @sols, [ grep { $_ } @candidate ] if sum( @candidate ) == $target;
}

say "found ", scalar @sols, " solutions:";
local $" = ' + ';
say "( $_->@* )" for @sols;

