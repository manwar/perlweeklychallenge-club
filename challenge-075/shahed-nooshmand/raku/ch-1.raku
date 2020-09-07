#!/usr/bin/env raku

my $S = 6;
my @C = 1, 2, 4;
say (@C Zxx @$_).map: |* for change $S, @C;

sub change($total, @coins is copy) {
    my $coin = @coins.shift;
    my $max-count = $total ÷ $coin;

    return $total %% $coin ?? $max-count !! [] if @coins == 0;

    my @solutions = [];
    for 0..$max-count -> $count {
    	@solutions.push: [$count, |$_] for change $total − $count × $coin, @coins
    }
    return @solutions;
}
