#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       drive-it-in-reverse-then.pl
#
#       Reversible Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to find out all Reversible Numbers below 100.
# 
# 
#         A number is said to be a reversible if sum of the number and its
#         reverse had only odd digits.
# 
# 
#         For example,
# 
#             36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
#             17 is not reversible as 17 + 71 = 88, none of the digits are odd.
# 
#         Output
#             10, 12, 14, 16, 18, 21, 23, 25, 27,
#             30, 32, 34, 36, 41, 43, 45, 50, 52,
#             54, 61, 63, 70, 72, 81, 90
# 
#         Analysis:
# 
#         We could do this the easy way, or the hard way. Or maybe the hard
#         way, or the easy way, depending on when you start counting the
#         effort. We're going to front-load the effort here, and think this
#         thing through, which I suspect will yield an easy solution. With
#         considerably more mental effort.
# 
#         Or we could just test the numbers from 1 to 100 and select any
#         that fit. That's also easy, but kind of boring.
# 
#         The main drive behind the over-exertion and over-thinking is me
#         trying to figure out why these numbers are called reversible.
#         There are several examples of so-called reversible numbers in the
#         literature, but none with this definition that also give any
#         inkling as to *why* they are called this. What do odd digits have
#         to do with reversiblity? I'm still wondering about that. I'm
#         inclined to think its something made-up for a programming puzzle
#         and nothing more.
# 
#         We do, of course, reverse the number at one stage. Then we add
#         the number and its reverse, and see if the digits are odd. Not
#         that the number is odd, which of course would also be true, but
#         that the all of the digits themselves are odd.
# 
#         How do you make an odd number? You add an even number and an odd
#         one. For practical purposes 0 will be considered even here.
#         However, we need to consider we are looking for numbers less than
#         100. These will have only wo digits, so if leading zeros are not
#         allowed, then all zeros are out. However from the example we list
#         30, so  it appears they are. Zeros, then, are in. At least when
#         the numbers are reversed. This application seems... inconsistent.
#         But then I don't think there is a rigorous mathematical
#         definition to reversing the digits of a number. Seems kind of a
#         free-for-all.
# 
#         Let's keep going on the less-than-one-hundred angle. These
#         numbers have 1 or 2 digits. Single digit numbers reverse to the
#         same digit, and the sum of any digit with itself is 2 times the
#         value, and hence even.
# 
#         So single digit values are out.
# 
#         We are left with two-digit values with one even and one odd
#         digit.
# 
#         But what about if we carry? If we carry a 1 and form a
#         three-digit number then the leading 1 is odd, so that might work,
#         right? THe thing is that we need even-odd pairs that when swapped
#         create odd-even pairs, or vice versa. If the rightmost sum in the
#         sum is odd, then the left sum, comprised of the same digits, will
#         also be odd. But carrying over a 1 from the right sum will make
#         the left sum — which because it also will carry becomes the
#         center digit in the final sum — adds 1 to that odd number and
#         becomes even.
# 
#         So all carrying is excluded, at least with 2-digit numbers.
# 
#         Do we have enough information now? I believe we do. We need a
#         list of two-digit numbers such that one digit is even and the
#         other odd, where the two digits summed together do not exceed 9,
#         and the first digit is not zero. Any number that satisfies these
#         criteria should be so-called reversible. I'd rather call them
#         something more desriptive, like odd-digit reversible, but
#         whatever. Perhaps I shall.
# 
#         Three-Digit Numbers
#         -------------------
# 
#         For 3-digit numbers the rules are a little different. In these,
#         the center digit will always reverse to itself, and hence sum to
#         an even number. So the only way for a 3-digit number to be
#         reversible is for the one's position to carry. The reverse-sum of
#         these numbers then will always be of the for 1xxx, where x is
#         some odd digit.
# 
#         In these number the first and third position must therefore sum
#         to an odd number greater than 9, and the middle position can be
#         any number that will not carry with 1 added, which is to say 0
#         through 4. It's easier to construct these out-of-order, modifying
#         the loops of our 2-digit solution and adding a third interior
#         loop to fit center digit
# 
#         Four Digits 
#         -----------
# 
#         For four digits we get some number mnpq, with positions 1234,
#         such that
# 
#         m + q  is odd n + p  is odd
# 
#         if m + q carries, then the interior pair n + p must be even so it
#         becomes odd when the carry is added at position 3 . However this
#         would also need to carry to make position 2 odd as well. Position
#         2, in turn , would then carry to postion 1, which like postion 4
#         must be odd already. So m + q cannot carry. Internally, n + p is
#         restrained by the same logic as the 2-digit numbers — if they at
#         postion 2 then  position 3, which was odd, will become even. So
#         this pair cannot carry either. The constrints on carrying for the
#         four digit numbers are the same as taking the set of two digit
#         numbers and inserting one member of the set inside another, as
#         these are the only allowed pairings.
# 
#         Each combination of two digit odd-digit reversible numbers will
#         construct a new 4-digit number, with an small modification: the
#         addition of a new valid group of inserted values — 01,03,05,07,09
#         — that allow a leading 0. Thus 2015 is allowed as a valid
#         reversible. See what I said before about disallowing leading
#         zeros being inconsistent? A large amount of what we're doinghere
#         isn't math, but symbolic pairings according to sets of rules that
#         happen to be mathematically based. If we allowed leading zeros
#         the scaling would be perfect, instead of the outmost pairs being
#         further constrained. The quantity of 4-digit numbers is not then
#         the 2-digit quantity squared, but somewhat more. However this
#         scaling, limited or not, works for all even numbers of digits.
#         The number is symmetrically divided down the middle, with left
#         and right pairs that sum to an odd number less than 10
# 
# 
#         Five Digits 
#         -----------
# 
#       
#         Pretty sure that's not true.
# 
#         Given a number mnpqr with positions 12345, then:
# 
#         m + r is odd
# 
#         n + q is odd
# 
#         Position 3 maps to itself so must receive a carry to be odd, thus
#         p4 is odd and carries to p3, and so p2 carries as well to p1. But
#         p1 initially sums the same as p5, which is odd already, and this
#         carry will make it even, which is disallowed.
# 
#         The pattern of chaining carries established in 3-digit values is
#         broken by the presence of multiple digits surrounding the central
#         pivot. I believe there can be no 5-digit odd-digit-reversible
#         numbers.
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


## we'll construct TWO DIGIT numbers in the form $m$n

my @twos;

FIRST: for my $m ( 1..9 ) {
    for my $n ( 0..9 ) {
        next unless ($m + $n) & 1;    ## sum is odd
        next FIRST if $m + $n > 9;    ## but will not carry
        push @twos, "$m$n";
    }
}

say "@twos";

## THREE DIGIT $m$p$n

my @threes;

ONE: for my $m ( 1..9 ) {
    TWO: for my $n ( 0..9 ) {
        next unless ($m + $n) & 1;          ## sum is odd
        next unless $m + $n > 9;            ## must carry
        for my $p (0..9) {
            next TWO if 2 * $p + 1 > 9 ;    ## must not carry
            push @threes, "$m$p$n";
        }
    }
}

@threes = sort { $a<=>$b } @threes;

say "@threes";


## FOUR DIGITS

## first we get a list of two-digit ODR numbers (that's Odd-Digit-Reversible to you)
## we could duplicate the code above or just use @twos. 
## we'll just use @twos that we already computed, then.

my @fours;

## we need the 0-based pairs to extend @twos, though

my @twos_ext = (@twos, qw( 01 03 05 07 09 ) );

## insert from @twos-ext between the digits of a value from @twos
for my $outer ( @twos ) {
    for my $inner ( @twos_ext ) {
        push @fours, (substr $outer, 0, 1).$inner.(substr $outer, 1, 1);
    }
}

@fours = sort { $a<=>$b } @fours;

say "@fours";
