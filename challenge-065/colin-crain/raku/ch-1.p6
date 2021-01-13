#!/usr/bin/env perl6
#
#
#       digikey_values.raku
#
#         TASK #1 › Digits Sum
#         Submitted by: Mohammad S Anwar
#         Tuned and Tweaked by: Ryan Thompson
#
#             You are given two positive numbers $N and $S.
#
#             Write a script to list all positive numbers having exactly
#             $N digits where sum of all digits equals to $S.
#
#             Example
#             Input:
#
#                 $N = 2
#                 $S = 4
#
#             Output:
#                 13, 22, 31, 40
#
# # # # # # # # #
#
#         METHOD
#
#             Perl and Raku have the wonderful ability to seamlessly
#             glide between looking at individual digits as either raw
#             glyphs or atomic numbers. In certain circumstances this
#             peculiar eye is even extended to other, non-digit
#             characters. As such we can assemble arbitrary digits, so
#             as to positionally represent numbers, in exactly the same
#             way we would do so with a pencil and paper.
#
#             This ability to construct strings of digits and such, and
#             then evaluate those strings as representing numbers, opens
#             up all kinds of questions of arithmetic number theory. Not
#             cleanly fitting into the more common sub-disciplines, one
#             might call it positional number theory, or as I like to
#             call it (after its poetic cognate), Concrete Number
#             Theory. We are no longer looking at just the meaning of
#             the number, but also how it looks on the page.
#
#             To solve the challenge, we will need to construct a list
#             of all numbers of a given positional length. For any given
#             length, that list resembles a range like 1000..9999, which
#             can be compuuted with
#
#                 ($digits-1)**10...($digits**10)-1
#
#             There is undeniably a beautiful symmetry in that
#             statement. We will also need to make an exception of the
#             numbers of length 1, that list spans from 0 to 9, but it's
#             easier to just allow for the single edge case digits=1 and
#             target=0. We can accomplish this very clearly using a
#             give/when construct.
#
#             We can then filter our list with a function that sums the
#             digits to allow elements that match the desired value. To
#             sum the digits, we take a number and break it apart as we
#             would a string into non-positional digits again, iterating
#             through the list produced and summing to a collector. We
#             could bring use the [+] metaoperator, which I do so love
#             doing, but have opted this time to use .sum, for no
#             particular reason other than it was made especially to do
#             this.
#
#             Machines want to be used. It's good to spread the love
#             around.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



sub MAIN (Int:D $digits = 4, Int:D $total = 19 ) {

    my @result_set = grep { ($_.comb.sum) == $total }, (10**($digits-1)..10**$digits-1);

    given @result_set {
        when .list.elems > 0                { .say for @result_set }
        when $digits == 1 and $total == 0   { say 0 }
        say "no numbers of length $digits sum to $total";  ## default
    }
}
