#! /opt/local/bin/perl
#
#       dinner_for_dictators.pl

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

#         Example 1:
#         Input: $N = (1, 2, 2)
#         Explanation:
#         Applying rule #a, each candidate will get one candy. So total candies
#         needed so far 3. Now applying rule #b, the first candidate do not get
#         any more candy as its rank is lower than it's neighbours. The second
#         candidate gets one more candy as it's ranking is higher than it's
#         neighbour. Finally the third candidate do not get any extra candy as
#         it's ranking is not higher than neighbour. Therefore total candies
#         required is 4.
# 
#         Output: 4

#         Example 2:
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
#             "You are tasked with providing candied treats for a dinner, at the
#             place settings along a long table on a dais facing a large hall.
#             The diners are to be a gathering of dictators and very powerful
#             men, seated in a line facing the room. Because they are by nature
#             petulant and insecure, each man requires an offering of candy as a
#             token of respect, in an amount that he deems worthy of his
#             position amongst his peers. Every man of higher stature than his
#             neighbors to either side must always have more candies than them,
#             lest he be percieved as weak. There are no exceptions, and failure
#             to properly dispense the correct amounts will result in
#             imprisonment at best. For obscure reasons of protocol and
#             diplomacy, there is no apparent ordering to the table seating, so
#             you must rely on ratings asigned to the individual seat positions
#             to know how to fill the candy bowls. As the government hosting the
#             feast has only been able to procure a limited amount of candies
#             for you to distribute, you will have no choice but to dispense the
#             minumum number possible to fulfill your obligations, hoping you
#             will have enough to supply the whole table. May the odds be
#             forever in your favor."

#         method:
#             It took me a while to figure out what was realy being asked here.
#             I spent some time constructing an additive method, making multiple
#             passes across the data and augmenting values for each setting as
#             required until no more adjustment was necessary, but found the
#             result lacking; it seemed to work but was somehow missing the
#             point. But it got me looking at the relationship between the
#             solutions and the source arrays.
# 
#             Then it occured to me that what we were doing was minimizing the
#             data, while maintaining the relative relationships between
#             adjacent elememts. Those larger than their neighbor will remain
#             greater, those less, less. But the whole list will have those
#             differences minimized and pushed as far as possible towards 1, the
#             base value.
# 
#             It's somewhat akin  to normalizing and compressing a signal, but
#             not quite. Here both the compression and rezeroing are extremely
#             local events, making the adjustments discontinuous. For instance,
#             any element less than both its neighbors will be reduced all the
#             way to 1, reestablishing the lower boundary again.
# 
#             Taking this to mind, the process is very simple: starting with the
#             original array, the value of each element is reduced according to
#             the rule that if it is larger than its neighbors, the new value is
#             one more than the larger neighbor's output, and if smaller than
#             both, then 1.
# 
#             The part that makes this work, though, is the order of selection.
#             By moving the smallest elements first, the baseline positions are
#             established, then the elements that need to be one more than this
#             are placed, then one more than that. To do this we will need a
#             list of the indexes of the original array, resorted according to
#             the array values, lowest to highest. Working through this, in the
#             end every element will only need to be valued once in the output
#             array.
# 



#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


my @input  = scalar @ARGV   ? @ARGV 
                            : (1, 9, 5, 2, 6, 8, 9, 10, 2, 5, 1);

my @output;

normalize(\@input, \@output);

say "input:  @input";
say "output: @output";

## ## ## ## ## SUBS:

sub normalize {
## starting from the smallest value, if the given index value is
## larger than either of its neighbors, then it is
## revalued in the output to be the larger of its neighbors' output plus one. If it is
## smaller than both it is 1.
    my ($in, $out) = @_;

    my @order = sort { $in->[$a] <=> $in->[$b] } keys $in->@*;  
    for my $i (@order) {
        my $min = 1;
        for (1,-1) {
            next if ( $i + $_ < 0 or not defined $in->[$i+$_]) ;
            if ($in->[$i] > $in->[$i+$_]) {
                $min = max($out->[$i+$_] + 1, $min);
            }
        }
        $out->[$i] = $min;    
    }
}

sub max {
    my $max = "-inf";
    for (@_) {
        $max = $_ if $max < $_;
    }
    return $max;
}