#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %count = @ints.Bag;
    my $previous = 0;
    my $without = 0;
    my $current = 0;

    for %count.keys.sort -> $k {
        if $k - 1 != $previous {
            ($without, $current) = (($without, $current).max, $k * %count{$k} + ($without, $current).max);
        } else {
            ($without, $current) = (($without, $current).max, $k * %count{$k} + $without);
        }
        $previous = $k;
    }

    ($without, $current).max.say;
}