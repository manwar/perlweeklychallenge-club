#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $min = 0;
    my $current = 0;

    for @ints -> $n {
        $current += $n;
        if $current < $min {
            $min = $current;
        }
    }

    say 1 - $min;
}
