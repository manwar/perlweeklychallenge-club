#!/usr/bin/raku

sub MAIN(
    $alien,
    *@words
) {
    my %order = $alien.comb.antipairs;

    @words
        .sort({
            %order{ $^a.comb } cmp %order{ $^b.comb };
        })
        .join(q{ })
        .say;
}

