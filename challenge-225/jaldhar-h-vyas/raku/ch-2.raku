#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @left = (0);
    for 0 ..^ @ints.end -> $i {
        @left.push(@ints[0 .. $i].sum);
    } 

    my @right = (0);
    for (0 ^.. @ints.end).reverse -> $i {
        @right.unshift(@ints[$i .. *-1].sum);
    } 


    say q{(}, (@left Z- @right).map({ .abs }).join(q{, }), q{)};
}