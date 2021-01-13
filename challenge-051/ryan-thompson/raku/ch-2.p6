#!/usr/bin/env perl6

# ch-2.p6 - Colourful numbers of 3 digits
#
# Ryan Thompson <rjt@cpan.org>

# This *almost* works, but combinations includes (first,last)
#$n.comb».Int.combinations(1..3)».reduce({$^a * $^b}).unique.elems == 7;

#| Returns True if a 3-digit number is colourful
sub colourful( Int $n where { 100 ≤ $n ≤ 999 } --> Bool ) {
    my @D = $n.comb».Int;
    !([0], [1], [2], [0,1], [1,2], [0,1,2]).map({ [*] @D[$_] }).repeated;
}

.say for (100..999).grep: &colourful;
