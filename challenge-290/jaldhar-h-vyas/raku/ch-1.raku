#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $result = False;

    for @ints.keys.combinations(2) -> $combo {
        my $i = @$combo[0];
        my $j = @$combo[1];

        if $i != $j && @ints[$i] == 2 * @ints[$j] {
            $result = True;
            last;
        }
    }

    say $result;
}