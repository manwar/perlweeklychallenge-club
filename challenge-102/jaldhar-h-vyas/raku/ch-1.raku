#!/usr/bin/raku

sub isRare(Int $r, Int $r1) {
    return sqrt($r + $r1) %% 1 && sqrt($r - $r1) %% 1;
} 

sub MAIN(
    Int $N #= length of rare number
) {
    my $xfactor = $N < 3 ?? 11 !! 121;
    my $yfactor =  $N < 4 ?? 11 !! 1089;

    for (10 ** ($N - 1)) ..^ (10 ** $N) -> $n {
        my $r = $n;
        my $r1 = "$n".flip.Int;

        if ($r == $r1) {
            next;
        }

        if $N %% 2 {
            if ($r + $r1) %% $xfactor && isRare($r, $r1) {
                say $r;
            }
        } else {
            if ($r - $r1) %% $yfactor && isRare($r, $r1) {
                say $r;
            }
        }
    }
}