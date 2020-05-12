#!/usr/bin/env raku

# Usage: raku ch-2.raku 0 1 2 5 2 21

sub MAIN (*@L where @L.all ~~ UInt) {
    my $y = @L.pop;
    my $x = @L.pop;
    my $list = @L>>.Str;

    my @ans = gather {
        for (10**($x-1)..^$y) -> $num {
            my $digits = $num.comb;

            if $digits (<=) $list {
                take $num;
            }
        }
    }

    say @ans.join(", ");
}
