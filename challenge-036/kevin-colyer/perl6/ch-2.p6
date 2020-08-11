#!/usr/bin/perl6
use v6;

use Test;

=begin pod

Task 36.2

Write a program to solve Knapsack Problem.
There are 5 color coded boxes with varying weights and amounts in GBP. Which boxes should be choosen to maximize the amount of money while still keeping the overall weight under or equal to 15 kgs?

R: (weight = 1 kg, amount = £1)
B: (weight = 1 kg, amount = £2)
G: (weight = 2 kg, amount = £2)
Y: (weight = 12 kg, amount = £4)
P: (weight = 4 kg, amount = £10)

Bonus task, what if you were allowed to pick only 2 boxes or 3 boxes or 4 boxes? Find out which combination of boxes is the most optimal?

=end pod

class box {
    has Str $.colour;
    has Int $.weight;
    has Int $.amount;
}

my $box=box.new(colour => 'R', weight => 1, amount => 1 );
my @boxes=
    box.new(colour => 'R', weight => 1 , amount => 1 ),
    box.new(colour => 'B', weight => 1 , amount => 2 ),
    box.new(colour => 'G', weight => 2 , amount => 2 ),
    box.new(colour => 'Y', weight => 12, amount => 4 ),
    box.new(colour => 'P', weight => 4 , amount => 10),
;

# calculate all possible permutations of n boxes
# simple integers are permutated rather than create multiple objects
my @combinations=(^@boxes.elems).combinations;

my $max_weight=15;
my $max_boxes=@boxes.elems;

sub knapsack(@combinations,@boxes,$max_weight,$max_boxes) {
    my @cands= gather for @combinations -> @c {

        # prune combinations with more than max boxes
        next unless @c.elems <= $max_boxes;

        my $w= @boxes[@c]>>.weight.sum;

        # prune overweight combinations
        next unless $w <= $max_weight;

        # cache for later
        my %wv= comb => @c, w => $w, v => @boxes[@c]>>.amount.sum;
        take %wv;
    }
    # sort in descending order - highest value first.
    @cands.=sort({$^a<v> <= $^b<v>});

    return @cands[0];
}

my %best_value= knapsack(@combinations, @boxes, $max_weight, $max_boxes);
say "(max boxes $max_boxes, max weight $max_weight)";
say "Best boxes are "~ (@boxes[$_].colour for flat %best_value<comb>).sort.join(" ");
say "total weight: {%best_value<w>}Kg, value: £{%best_value<v>}";

# bonus task
my $best_num_boxes=0;
my $best_GBP_value=0;
my %best;

for 2..4 -> $max_boxes {
    my %best_value = knapsack(@combinations, @boxes, $max_weight, $max_boxes);
    #     say "\n(max boxes $max_boxes, max weight $max_weight)";
    #     say "Best boxes are "~ (@boxes[$_].colour for flat %best_value<comb>).sort.join(" ");
    #     say "total weight: {%best_value<w>}Kg, value: £{%best_value<v>}";
    if %best_value<v> > $best_GBP_value {
        $best_GBP_value = %best_value<v>;
        %best=%best_value;
        $best_num_boxes = $max_boxes;
    }
}

say "\nBonus\nOptimal number of boxes to maximise value for 2 to 4 boxes is: \n$best_num_boxes with {%best<w>}Kg, value: £{%best<v>}";

