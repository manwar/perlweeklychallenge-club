#!/usr/bin/raku

sub MAIN(
    *@nums
) {
    my @results;

    my @indices = @nums.keys;
    for @indices.combinations(2 ..^ @indices.elems) -> @combo {
        my @subset = @combo.map({ @nums[$_] });
        if @subset.sum == @combo.sum + @combo.elems {
            @results.push(@subset);
        }
    }

    say @results
        ?? @results.map({ q{(} ~ @$_.join(q{, }) ~ q{)} }).join(q{, })
        !! q{()};
}
