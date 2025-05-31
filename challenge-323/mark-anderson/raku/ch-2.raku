#!/usr/bin/env raku
use Test;

is tax-amount(10, ([3,50], [7,10], [12,25])), 2.65;
is tax-amount(2,  ([1,0],  [4,25], [5,50])),  0.25;
is tax-amount(0,  ([2,50])),                  0;

sub tax-amount($income, @tax)
{
    my @brackets = @tax.flat[0,2...*];
    my @taxes    = @tax.flat[1,3...*];
    my $end = @brackets.first(* >= $income, :k);

    @brackets[$end] = $income;
    @brackets = flat 0, @brackets[0..$end];

    ([+] @brackets.rotor(2 => -1).flat.map({ $^b - $^a }) Z* @taxes) / 100
}
