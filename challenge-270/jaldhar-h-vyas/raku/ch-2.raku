#!/usr/bin/raku

sub MAIN(
    $x, $y, *@ints
) {
    my $max = @ints.max;
    my @unequals = @ints;
    my $cost = 0;

    loop {
        @unequals = @unequals.grep({ $_ != $max });
        my $remaining = @unequals.elems;

        if $remaining > 1 {
            @unequals[@unequals.keys.pick(2)]»++;
            $cost += $y;

        } elsif $remaining == 1 {
            @unequals[0]++;
            $cost += $x;

        } else {
            last;
        }
    }

    say $cost;
}