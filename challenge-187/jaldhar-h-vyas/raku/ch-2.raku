#!/usr/bin/raku

sub MAIN(
    *@n
) {
    my $maximum = -Inf;
    my @maxima;

    for @n.permutations.map({ @$_[0 .. 2]; }).unique -> $combo {
        my ($a, $b, $c) = @$combo;
        if ($a + $b > $c) && ($b + $c > $a) && ($a + $c > $b) {
            if ($a + $b + $c) > $maximum {
                @maxima = ();
            }
            if ($a + $b + $c) >= $maximum {
                $maximum = $a + $b + $c;
                @maxima.push(($a, $b, $c));
            }
        }
    }

    if @maxima.elems == 0 {
        say '()';
    } else {
        if @maxima.elems > 1 {
            @maxima = @maxima.grep({ @$_[0] >= @$_[1] && @$_[1] >= @$_[2]; });
        }
        say @maxima[0];
    }
}