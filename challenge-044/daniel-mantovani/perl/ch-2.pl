# Make it $200
# You have only $1 left at the start of the week.
# You have been given an opportunity to make it $200.
# The rule is simple with every move you can either
# double what you have or add another $1.
# Write a script to help you get $200 with the smallest number of moves.

use strict;
use warnings;
use v5.10;

# from the problem, you can conclude that at every intermediate step,
# you should multiply by 2 when possible, because it will sum up at
# least same amount that adding $1.
#
# what I mean is that, if for example your current total is $25, there
# is not better steps that multiply by 2 three consecutive times,
# to get the final $200
#
# So if we analize the problem backwards, we can start from the target
# ($200), then divide by 2 whenever we can, or substract 1 if you cannot.
# At the end, we shold do the inverse operation on each step, in
# a reversed order.
#
# There should not be shorter sequences that this one
#

#
# will be something like this:
#

my $target = shift @ARGV;
die "Usage: perl $0 <target>" unless $target =~ /^\d+$/ && $target > 0;

my @steps;
while ($target > 1) {
    if ($target % 2) {
        push @steps, sprintf('Add $1 to $%i (new total $%i)', $target-1, $target);
        $target--;
    } else {
        push @steps, sprintf('Multiply $%i by 2 (new total $%i)', $target / 2, $target);
        $target /= 2;
    }
}

for my $i (1..@steps) {
    say "Step #$i: ", pop @steps;
}

#
# example usage:
#
# $> perl ch-2.pl 200
# Step #1: Multiply $1 by 2 (new total $2)
# Step #2: Add $1 to $2 (new total $3)
# Step #3: Multiply $3 by 2 (new total $6)
# Step #4: Multiply $6 by 2 (new total $12)
# Step #5: Multiply $12 by 2 (new total $24)
# Step #6: Add $1 to $24 (new total $25)
# Step #7: Multiply $25 by 2 (new total $50)
# Step #8: Multiply $50 by 2 (new total $100)
# Step #9: Multiply $100 by 2 (new total $200)
# $>
