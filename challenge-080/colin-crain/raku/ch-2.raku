#!/usr/bin/env raku
# 
#
#       dinner-for-dictators.raku
#
#       visual aid: https://en.wikipedia.org/wiki/File:Dinner_of_the_Dictators_wiki.jpg
#
#         TASK #2 › Count Candies
#         Submitted by: Mohammad S Anwar
#         You are given rankings of $N candidates.
# 
#         Write a script to find out the total candies needed for all
#         candidates. You are asked to follow the rules below:
# 
#         a) You must given at least one candy to each candidate.
#         b) Candidate with higher ranking get more candies than their mmediate neighbors on either side.

#         Example:
#         Input: $N = (1, 4, 3, 2)
#         Explanation:
#         Applying rule #a, each candidate will get one candy. So total candies
#         needed so far 4. Now applying rule #b, the first candidate do not get
#         any more candy as its rank is lower than it's neighbours. The second
#         candidate gets two more candy as it's ranking is higher than it's both
#         neighbour. The third candidate gets one more candy as it's ranking is
#         higher than it's neighbour. Finally the fourth candidate do not get
#         any extra candy as it's ranking is not higher than neighbour.
#         Therefore total candies required is 7.
# 
#         Output: 7
# 
#    ----------------------------------------------------------------------------

#         rephrasing for dramatic effect:
# 
#             "You are tasked with providing candied treats for a dinner, at the
#             place settings along a long table on a dais facing a large hall.
#             The diners are to be a gathering of dictators and very powerful
#             men, seated in a line facing the room. Because they are by nature
#             petulant and insecure, each man requires an offering of candy as a
#             token of respect, in an amount that he deems worthy of his
#             position amongst his peers. Every man of higher stature than his
#             neighbors to either side must always have more candies than them,
#             lest he be perceived as weak. There are no exceptions, and failure
#             to properly dispense the correct amounts will result in
#             imprisonment at best. For obscure reasons of protocol and
#             diplomacy, there is no apparent ordering to the table seating, so
#             you must rely on ratings asigned to the individual seat positions
#             to know how to fill the candy bowls. As the government hosting the
#             feast has only been able to procure a limited amount of candies
#             for you to distribute, you will have no choice but to dispense the
#             minumum number possible to fulfill your obligations, hoping you
#             will have enough to supply the whole table. And may the odds be
#             ever in your favor."
# 
#           Note: added smallest values criteria to task
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@input) ;
@input.elems == 0 and @input = 1, 100, 5, 2, 6, 8, 9, 10, 2, 5, 1;
my @output;

normalize(@input, @output);

say "input:  ", @input;
say "output: ", @output;

sub normalize (@input, @output) {
## starting from the smallest value, if the given index value is larger than
## either of its neighbors, then it is valued in the output to be the larger of
## its (smaller) neighbors' output plus one. If it is smaller than both it is 1.

    my @order = @input.keys.sort:{ @input[$_] } ; ## order idx by value
say @order;
    for @order -> $i {
        my $min = 1;
        for 1, -1 -> $Δ {
            given $i + $Δ {
                next unless $_ ~~ any @input.keys;          ## ignore out of bounds
                if @input[$i] > @input[$_] {
                    $min = (@output[$_] + 1, $min).max;     ## just above max of smaller values
                }
            }
        }
        @output[$i] = $min;    
    }
}
