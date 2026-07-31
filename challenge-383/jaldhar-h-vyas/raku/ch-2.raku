#!/usr/bin/raku

sub nearest($n) {
    state @near = (0x0, 0x33, 0x66, 0x99, 0xCC, 0xFF);
    my $result = @near[*-1];

    for 1 .. @near.end -> $i {
        if $n <= @near[$i] {
            $result = ($n - @near[$i - 1]) < (@near[$i] - $n)
                ?? @near[$i - 1]
                !! @near[$i];
            last;
        }
    }

    return '%02X'.sprintf($result);
}

sub MAIN(
    $color
) {
    my ($r, $g, $b) = $color.comb(2).map({ nearest("0x$_") });

    say "#$r$g$b";
}
