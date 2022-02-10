#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       150-1-the-51st-little-piece-of-string.pl
#
#       Fibonacci Words
#         Submitted by: Mohammad S Anwar
#         You are given two strings having same number of digits, $a and $b.
# 
#         Write a script to generate Fibonacci Words by concatenation of
#         the previous two strings. Finally print 51st digit of the first
#         term having at least 51 digits.
# 
#         Example:
#             Input: $a = '1234' $b = '5678'
#             Output: 7
# 
#             Fibonacci Words:
# 
#             '1234'
#             '5678'
#             '12345678'
#             '567812345678'
#             '12345678567812345678'
#             '56781234567812345678567812345678'
#             '1234567856781234567856781234567812345678567812345678'
# 
#             The 51st digit in the first term having at least 51 digits:
#                 '1234567856781234567856781234567812345678567812345678' is 7.

#         method:
# 
#             The Fibonacci sequence is defined by what is known asa
#             "recurrence relation". Elements previously defined in the
#             sequence re-occur as components of later definitions
#             according to certain rules of construction. Thus it follows
#             that values at a certain points in the sequence cannot
#             generally be constructed until the required previous values
#             that they are contingent on existing have themselves been
#             constructed. An ordering is necessitated, and to evaluate the
#             n-th member of the sequence we need to work backwards
#             recursively, defining the components, and their components,
#             as required until we arrive at known values and can return
#             forward in the construction.
# 
#             The recurrence relation of the Fibonacci numbers is
# 
#                 F(n) = F(n-1) + F(n-2)
# 
#             but this is not the only recurrence relation that can exist,
#             and many variations have been explored. In the simplest form,
#             a new element is a function of the value for the single
#             preceding element. The specific Fibonacci sequence works
#             forward from the starting values (0,1) but other inital
#             conditions with the same recurrence can be constructed.
#             Altering the coeffiecients of the components is another
#             option, as is involving more than the two previous terms in
#             the computation, or altering the operations acting on the
#             previous elements selected to something other than simple
#             addition.
# 
#             This interesting qualities about these sequences is often the
#             way the mathematics of the recursive definition relates to
#             such other mathematical ideas such as series expansions and
#             generating functions. The fact that its recursive definition
#             notwithstanding the n-th element of the Fibonacci sequence
#             can be directly calculated using a function of n, known as
#             Binet's formula, a closed-form expression, reveals deep
#             connections between linear recurrence relations and linear
#             differential equations.
# 
#             This generalized branching out from the specific defintion of
#             the Fibonacci numbers brings us to the idea that we needn't
#             even require numbers to apply a recurrence relation. The
#             method of constuction is the key pattern; that this is made
#             from that and that, and those made themselves from smaller
#             components, all according to a defined set of rules that
#             remain the same independent of scale. The one-millionth term
#             is computed from the previous two, in the same way the third
#             term is. If we use strings instead of numbers, and in a
#             manner analogous to addition concatinate the strings, we have
#             what is known as a sequence of Fibonacci words. If the
#             initial conditions specify that the strings have equal
#             length, as is the case here, than the lengths of the strings
#             composed will follow the Fibonacci sequence, with the values
#             multiplied by the word length.
# 
#             The term "Fibonacci word" is often used for the
#             closely-defined sequence using the two binary digits
#             (0,1) as initializers and applying concatenation. This task
#             takes a broader approach, allowing any equal-length strings
#             of digits for the starting values. 
# 
#             Unary notation can be thought of as moving around piles of
#             sticks. Starting with the two "words" ("", 1) the resulting
#             sequence, viewed as numbers in unary notation, is not just
#             similar to but is the Fibonacci numbers.
# 
#             Starting with a null, empty string (using '' for this lack of
#             a character) we initialize with 
# 
#                 ('', 1)
# 
#             Once we start generating new values we get
# 
#                 '', 1, 1, 11, 111, 11111, 11111111, ...
# 
#             As we can see the count of the 1s shows the Fibonacci
#             sequence in unary:
# 
#                 0, 1, 1, 2, 3, 5, 8, ...
# 
#             We will still use decimal notation of the sequence index, and
#             construct the terms the same way, only applying the string
#             concatenation operator. 
# 
#             Because this operation is not commutative, we need to specify
#             that F(n) = F(n-2) • F(n-1).
# 
#             Because our indexing is 0-based we are looking for the
#             character at index 50.
# 
# 
# 
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##t



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $zero = shift // qw( 1234 );
my $one  = shift // qw( 5678 );

my @F = ($zero, $one);

while (length $F[-1] < 51) {
    push @F, $F[-2] . $F[-1]
}

say "the words generated, with a helpful guide:\n";
say $_ for @F;
say '';

say "0123456789" x 6;
say (map {"$_         "} (' ', 1..5));
say '';

say "start string 0: ", $zero;
say "start string 1: ", $one;


say qq(\nthe 51st character in the first term long enough to have one is "), 
        (substr $F[-1], 50, 1), q(")



