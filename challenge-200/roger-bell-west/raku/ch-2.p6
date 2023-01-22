#! /usr/bin/raku

sub sevensegment($l) {
    my @disp = (0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67);
    my @v;
    if ($l == 0) {
        @v.push(0);
    } else {
        my $ll = $l;
        while ($ll > 0) {
            @v.push($ll % 10);
            $ll div= 10;
        }
        @v = @v.reverse;
    }
    my @d = [" " xx 6 * @v.elems] xx 7;
    for (@v.kv) -> $i, $vv {
        my $x = 6 * $i;
        my $da = @disp[$vv];
        if ($da +& 1 > 0) {
            for ($x + 1..$x + 3) -> $xa {
                @d[0][$xa] = '#';
            }
        }
        if ($da +& 2 > 0) {
            for (1..2) -> $y {
                @d[$y][$x + 4] = '#';
            }
        }
        if ($da +& 4 > 0) {
            for (4..5) -> $y {
                @d[$y][$x + 4] = '#';
            }
        }
        if ($da +& 8 > 0) {
            for ($x + 1..$x + 3) -> $xa {
                @d[6][$xa] = '#';
            }
        }
        if ($da +& 16 > 0) {
            for (4..5) -> $y {
                @d[$y][$x] = '#';
            }
        }
        if ($da +& 32 > 0) {
            for (1..2) -> $y {
                @d[$y][$x] = '#';
            }
        }
        if ($da +& 64 > 0) {
            for ($x + 1..$x + 3) -> $xa {
                @d[3][$xa] = '#';
            }
        }
    }
    for (@d) -> @r {
        say @r.join('');
    }
}

sevensegment(1234567890);
sevensegment(200);
