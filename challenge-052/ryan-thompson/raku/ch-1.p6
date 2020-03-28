#!/usr/bin/env perl6

# ch-1.p6 - Stepping Numbers
#
# Ryan Thompson <rjt@cpan.org>

my @step;
for (1..9) -> $n {
    @step.push: |map { $n ~ ($n+1..$_)        .join: '' }, $n..9;
    @step.push: |map { $n ~ ($_..$n-1).reverse.join: '' },  0..$n-1;
}

say @step».Int.grep( 100 ≤ * ≤ 999 ).sort;
