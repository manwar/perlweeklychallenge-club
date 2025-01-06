#!/usr/bin/raku

sub MAIN(
    $x, $y, *@str
) {
    my @dp = [0 xx ($y + 1)] xx ($x + 1);

    for @str -> $s {
        my $zeros = $s.comb.grep({ $_ eq '0' }).elems;
        my $ones = $s.comb.grep({ $_ eq '1' }).elems;

        for reverse 0..$x -> $i {
            for reverse 0..$y -> $j {
                if $i >= $zeros && $j >= $ones {
                    @dp[$i;$j] = max(@dp[$i;$j], 1 + @dp[$i - $zeros;$j - $ones]);
                }
            }
        }
    }

    say @dp[$x;$y];
}
