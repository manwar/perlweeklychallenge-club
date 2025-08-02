#!/usr/bin/raku

sub minOf3($a, $b, $c) {
    return $a < $b ?? ($a < $c ?? $a !! $c) !! ($b < $c ?? $b !! $c);
}

sub MAIN(
    *@args
) {
    my @matrix;
    for @args -> $row {
        @matrix.push($row.comb);
    }

    my $rows = @matrix.elems;
    my $cols = @matrix[0].elems;
    my $maxSide = 0;

    my @sl = (0 ..^ $rows).map({ [ (0) xx $cols ] });

    for 0 ..^ $rows -> $i {
        for 0 ..^ $cols -> $j {

            if @matrix[$i;$j] == 1 {
                @sl[$i;$j] = ($i == 0 || $j == 0)
                ?? 1
                !! minOf3(@sl[$i - 1;$j], @sl[$i;$j - 1], @sl[$i - 1;$j - 1]) + 1;

                if @sl[$i][$j] > $maxSide {
                    $maxSide = @sl[$i;$j];
                }
            }
        }
    }

    say $maxSide²;
}
