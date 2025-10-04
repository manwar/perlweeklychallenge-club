#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @quadruplets;

    for @args.combinations(4) -> $combo {
        my @sorted = @$combo.sort({$^a <=> $^b});
        if @sorted[0] + @sorted[1] + @sorted[2] == @sorted[3] {
            @quadruplets.push(@sorted);
        }
    }

    @quadruplets.elems.say;
}