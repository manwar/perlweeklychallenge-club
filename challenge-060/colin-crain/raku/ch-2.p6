use v6.d;

#
#       gathering_digits_down_under.raku
#
#         PWC 60 TASK #2
#         Find Numbers
#         Challenge by: Ryan Thompson
#             Write a script that accepts list of positive numbers (@L) and two
#             positive numbers $X and $Y.
#
#             The script should print all possible numbers made by concatenating
#             the numbers from @L, whose length is exactly $X but value is less
#             than $Y.
#
#             Example
#                 Input:
#
#                     @L = (0, 1, 2, 5);
#                     $X = 2;
#                     $Y = 21;
#
#                 Output:
#
#                     10, 11, 12, 15, 20
#
#         METHOD
#
#             This is another example of what I call concrete number theory, where
#             we conflate the ideas of numbers and the symbols used to represent
#             them. We’re going to assemble digits positionally rather than
#             mathematically, and then evaluate those resultant numbers according
#             to some criteria. In this case the number of positions is equal to
#             an input x, and the resultant number is less than an input y.
#
#             To manufacture the number, we’re going to combine elements from an
#             input array. Considering the choices as sets, we are looking for
#             permutations of combinations with repetitions of length k elements
#             from set n. This is known in Set Theory as
#
#                     k-element variations of n-elements with repetition
#
#
#             as distinguished from variations without repetition. For a list of n
#             elements we have
#
#                     VR(n,k) = n^k
#
#             variations; because every position can contain every element at any
#             time, so the product is
#
#                     n × n × n …
#
#             for as many positions as required. There is one small caveat to
#             this, however, and that is the number 0.
#
#             Despite the given specification given a list of positive numbers,
#             zero is neither positive nor negative, so does not belong according
#             to that rule. However the example list explicitly includes it, so we
#             will follow suit and allow it, despite the specification. Sometimes
#             we must figure out that what the customer wants is not exactly what
#             they asked for.
#
#             To create our master list of variations, we’ll create a list, and
#             then iterate through the elements one at a time, adding an new value
#             and creating a new set of variations for every option. Bu carefully
#             keeping track of indexes we can just keep just one list as a queue,
#             shifting elements off the front and adding new variations on the
#             end. As we allow repetition, it makes no sense to duplicate elements
#             in the input; it’s a set, not an ordered list. Thus if the number 2
#             is an element, if 2 is repeated later in the input it still can be
#             present in any position, so it makes no difference. We’ll allow it,
#             because you can’t control people, but roll our eyes a bit and filter
#             out duplicates. Also, it we sort our list before we start, the
#             results will come out sorted, which is nice.
#
#             We will use our now sorted and filtered list to start our list of
#             variations. At this point, the first digit of the final number, we
#             will need to address 0 again, because earlier we specifically
#             allowed it. The problem is if we have a leading zero on a number, it
#             will not, by convention, be considered in the final construction,
#             and as such will shorten the positional count of the result,
#             violating that criterium. As far as convention goes, in case there
#             was any question remaining whether leading zeros are allowed
#             (because I can certainly see a case for it) we refer again to the
#             text. The example given in the challenge does not include the
#             results 00, 01, 02, or 05. Ok, so that’s a no-no, and we must for
#             the initial value exclude 0 if it is present. After this it’s fine,
#             as it won’t affect position. So we will need to selectively filter
#             it out only for the initialization. We can either check the value at
#             index 0, because the list is positive and sorted, then remove it if
#             present, or grep the sorted array on the values themselves, which
#             will fail on 0. Kind of a high-pass filter.
#
#             But before we’re done there also exists a singular pathological case
#             to handle where x = 1 and the list includes 0. If we are not
#             allowing leading 0s, does a solitary 0 count as a valid answer?
#             Sure, it’s not a leading zero if it’s the only value present, even
#             if that value is the absence of value. Really this relates back to
#             the acceptance of 0 as a valid number at all, which is a much more
#             recent, non-obvious and complicated development than many people
#             understand, and entirely worthy of a discussion unto itself*. In
#             another way it reminds me of pluralizing cats: no cats, 1 cat, 2
#             cats. The progression is unexpectedly complex. So we eliminate the
#             leading 0 of the first result set, but need to add it back in one
#             case, when x = 1.
#
#             -----
#             *Kaplan, Robert (2000) The Nothing That Is: A Natural History of
#             Zero, Oxford: Oxford University Press.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN ( $x, $y, *@array) {
## @array   is array to be rearranged
## $x       is new number length
## $y       is larger than new number

    @array = @array.sort({$^a <=> $^b});

    ## removes leading 0, unless x = 1
    my @result = $x == 1 ?? @array
                         !! @array.grep: { $_ };

    for 2..$x {
        ## note the length of the queue at this moment
        my $end = @result.end;
        for 0..$end {
            my $num = @result.shift;
            for @array -> $next {
                @result.push: 10 * $num + $next;
            }
        }
    }

    .say for @result.grep: { $_ < $y };
}


