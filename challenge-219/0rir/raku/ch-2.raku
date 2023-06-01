#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
219-2: Travel Expenditure      Submitted by: Mohammad S Anwar
You are given two list, @costs and @days.

The list @costs contains the cost of three different types of travel
cards you can buy.

For example @costs = (5, 30, 90)

Index 0 element represent the cost of  1 day  travel card.
Index 1 element represent the cost of  7 days travel card.
Index 2 element represent the cost of 30 days travel card.
The list @days contains the day number you want to travel in the year.

For example: @days = (1, 3, 4, 5, 6)

The above example means you want to travel on day 1, day 3, day 4, day 5 and day 6 of the year.
Write a script to find the minimum travel cost.

Example 1:
Input: @costs = (2, 7, 25)
       @days  = (1, 5, 6, 7, 9, 15)
Output: 11

On day 1, we buy a one day pass for 2 which would cover the day 1.
On day 5, we buy seven days pass for 7 which would cover days 5 - 9.
On day 15, we buy a one day pass for 2 which would cover the day 15.

So the total cost is 2 + 7 + 2 => 11.
Example 2:
Input: @costs = (2, 7, 25)
       @days  = (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31)
Output: 20

On day 1, we buy a seven days pass for 7 which would cover days 1 - 7.
On day 10, we buy a seven days pass for 7 which would cover days 10 - 14.
On day 20, we buy a one day pass for 2 which would cover day 20.
On day 30, we buy a one day pass for 2 which would cover day 30.
On day 31, we buy a one day pass for 2 which would cover day 31.

So the total cost is 7 + 7 + 2 + 2 + 2 => 20.
=end comment

# For an array of travel dates (here day-numbers), a set of 3 prices and
# durations for travel passes, determine the lowest cost for all scheduled
# travel.
#
# TODO toward usefulness:
#   1) Use real Date dates.
#   2) Consolidate @price & @span into a Pass type.
#   3) Fancies like passes for a set period or set periods.

sub thrifty-pass( @travel-date, @price, @span -->Real) {
                      # Three sisters.
    my @date = @travel-date;    # value is date 
    my @cost;                   # value is date's expenditure
    my @ticket;                 # value is date's type of ticket, i.e its duration

    @date.push: ∞;              # A sink-hole in which to bury long look-a-heads.
    enum span < Day Week Mo >;
    my @cur-cost;           # candidate costs [day,week,month] for a @date element 

    @cost[@date.end] = 0;   # starting cost (in sink-hole)


    for  (@date.end-1)…0 -> $i {

        for ^@span -> $dur-idx {
            @cur-cost[$dur-idx] = @price[$dur-idx] + @cost[
                        @date.first( * ≥ @date[$i] + @span[$dur-idx], :k)
                        ];
       }

        my $best = @cur-cost.min;
        my $min-k = @cur-cost.first( * == $best, :k);
        @ticket[$i] = @span[$min-k];
        @cost[$i] = @cur-cost[$min-k];
    }
    return  @cost[0];
}


my @Test =
#   spans      prices        ydays                                      cost

    # varied prices
    [[1,7,30], [2,5,20], [39,53,174,202,208,240,244,278,340,342],        20,],
    [[1,7,30], [2,6,19], [1,2,3,5,7,10,11,12,14,20,30],                  16,],
    [[1,7,30], [2,7,19], [1,2,3,5,7,10,11,12,14,20,30],                  18,],
    [[1,7,30], [2,7,13], [1..14],                                        13,],
    [[1,7,30], [2,7,13], [1..31],                                        15,],
    [[1,7,30], [2,7,20], [1..14],                                        14,],
    [[1,7,30], [3,7,19], [1,2,3,5,7,10,11,12,14,20,30],                  19,],
    [[1,7,30], [3,5,20], [39,53,174,202,208,240,244,278,340,342],        27,],

    # 2 7 25
    [[1,7,30], [2,7,25], [1,],                                            2,],
    [[1,7,30], [2,7,25], [1,2],                                           4,],
    [[1,7,30], [2,7,25], [1..3],                                          6,],
    [[1,7,30], [2,7,25], [1..4],                                          7,],
    [[1,7,30], [2,7,25], [1..7],                                          7,],
    [[1,7,30], [2,7,25], [1..8],                                          9,],
    [[1,7,30], [2,7,25], [1,2,3,5,7,10,11,12,14,20,30,31],               20,],
    [[1,7,30], [2,7,25], [1,2,3,5,7,10,11,12,14,20,30,31],               20,],
    [[1,7,30], [2,7,25], [39,53,174,202,208,240,244,278,340,342],        20,],

    [[1,7,30], [2,7,25], [  |(1..7), |(10..14), |(30..59), 71,
                        194,195,196,197,198,199,200,
                        201,202,203,204,205,
                        208,    210,        213,214,
                        215,216,        219,220,221,
                        222,                227,228,
                        229,230,
                                238],                                    75,],
;

plan +@Test;

for @Test -> ( @span, @price, @travel-day, $cost ) {
    is thrifty-pass( @travel-day, @price, @span), $cost,
            "$cost <- @travel-day.raku()";
}

done-testing;
my @pass = 1,7,30;
my @cost = 2, 7, 25;
my @day  = 1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31;

say "\nInput:\t@pass = @pass.raku()\n\t@cost = @cost.raku()\n\t"
  ~ "@day  = @day.raku()\nOutput:\t", thrifty-pass( @day, @cost, @pass);
exit;
