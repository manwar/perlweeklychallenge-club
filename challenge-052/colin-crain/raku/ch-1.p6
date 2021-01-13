use v6.d;

#
#       stepping.raku
#
#         Stepping Numbers
#             Write a script to accept two numbers between 100 and 999. It
#             should then print all Stepping Numbers between them.
#
#             A number is called a stepping number if the adjacent digits have a
#             difference of 1. For example, 456 is a stepping number but 129 is
#             not.
#
#         method: another example of what I have begun to call problems in
#             "Concrete Number Theory"; where the objectives are not merely
#             placed in the relationships between values in the solutions, but
#             in the physical way that these numbers are represented on a page.
#
#             In this example we do not care so much as to what a number
#             represents, but rather whether its adjectant digits differ by 1.
#             It is not restricted that the difference should be either
#             ascending or descending or even consistant, thus we shall conclude
#             not only that 123 fits the bill and also 654 and 656.
#
#             In the Perl 5 solution, it was straightforward to separate the
#             digits of the target number using split // and check the
#             differences between the first and second and second and third
#             digits. In Raku we use comb for this, and it also works quite
#             nicely. That solution is shown in the stepping1() sub below. We
#             could have left it there; --It works! They said. --Leave it alone!
#             They said. --Stop touching it!
#
#             But we didn't. No, no we did not.
#
#             There is most definately a place for not overly abstracting and
#             just writing code that gets the job done, with algorithms crafted
#             to the dataset. In this case, we were restricted to a range of
#             three digit numbers by the challenge, and so we hard-coded in the
#             specific difference calculations. We rose to the challenge given
#             and that's fine. But logically the only real restriction on
#             stepping numbers is to have at least one number to step _from_ and
#             one number to step _to_. So how can we address this?
#
#             Well...
#
#             1. If we're opening up the field of options, the very first thing
#             to do is add
#
#                 and $_.abs > 9
#
#             to our grep, to filter out single digit numbers. Once this is in
#             place we need not worry about them further.
#
#             2. One nice addition from Perl to Raku is the :ex (for
#             :exhaustive) adjective for regular expressions, which functions
#             like /g with overlapping results. The parser will start at the
#             left and progress the position over one char at a time, sending
#             back a list of every possible match for a given pattern, even if
#             it overlaps a previous match, in contrast to :g and /g which
#             recommences the search at the end of the previous match. With the
#             power of this, we can match
#
#                 m:ex/\d\d/
#
#             which, given a 3-digit number, will match first the first two
#             digits and then the last two. The number 123, for example, will
#             return the list 12 and 23. For a longer number, it will continue
#             like this, producing as many pairs as it can find.
#
#             3. Once we have this initial breakdown we first section the digit
#             pairs using comb, then apply a subtraction reduction metaoperator
#             on the two digit list to get their difference. We take the
#             absolute value, and now we have a list of the absolute differences
#             between the sequential digits of the number. A sort of a
#             derivative, if you will.
#
#             4. Appending the value 1 and then applying an equality reduction
#             metaoperator to this list is equivalent to the chained equation
#
#                 $^a == $^b == 1
#
#             or alternately,
#
#                 $^a == 1 && $^b == 1
#
#             which in turn is the same as
#
#                 ($a - $b).abs == 1 && ($b - $c).abs
#
#             as seen in stepping1().
#
#             Neat! This logic is laid out sequentially in stepping2().
#
#             Now these steps can be chained and combined to make the code as
#             terse as we wish. Combining steps 1 and 2 is creating a list of
#             match results and then doing something to that list, which flows
#             nicely. This is shown in stepping3(). Removing the @parts variable
#             completely may be desirable; this yields stepping4(), but note we
#             need to explicitly cast an Array before we can append the 1 to it,
#             as even the compiler is having trouble following by now. At this
#             point, with two metaoperators, two manufactured lists and a
#             tertiary decision we are getting pretty opaque. But then again we
#             might as well get completely pathological about it and remove the
#             entire subroutine:
#
#             sub MAIN (Int:D $from, Int:D $to) {
#                     .say for ($from...$to).grep({([==] (($_~~m:ex/\d\d/).map({([-] $_.comb).abs})).Array.append: 1)?? 1 !! 0 and $_.abs > 9});
#             }
#
#             Which works just fine, but seriously? Way to lose the plot,
#             Batman! There's way too much going on in that for one line. I
#             think #3 is arguably the clearest, so we'll leave that one in
#             MAIN().
#
#             And it works on any integer inputs, positive or negitive, in any
#             order. Nice.
#
#
#
#


#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (Int:D $from, Int:D $to) {
    .say for ($from...$to).grep({stepping3 $_ and $_.abs > 9});         # note 1
}

## ## ## ## ## SUBS:

sub stepping1 ($num) {
    my ($a, $b, $c) = $num.comb;
    ($a - $b).abs == 1 && ($b - $c).abs == 1 ?? 1 !! 0;
}

sub stepping2 ($num) {
    my @parts = $num ~~ m:ex/\d\d/;         # note 2
    @parts .= map({([-] $_.comb).abs });    # note 3
    ([==] @parts.append: 1) ?? 1 !! 0;      # note 4

}

sub stepping3 ($num) {
    my @parts = ($num ~~ m:ex/\d\d/)
                    .map({([-] $_.comb).abs });
    ([==] @parts.append: 1) ?? 1 !! 0;      # note 4

}

sub stepping4 ($num) {
    ([==] (($num ~~ m:ex/\d\d/).map({([-] $_.comb).abs })).Array.append: 1) ?? 1 !! 0;
}
