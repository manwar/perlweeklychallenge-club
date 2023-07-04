#!/bin/env raku

unit sub MAIN(UInt:D $N where *.chars > 2);

sub is-additive(Str:D $N is rw, Str:D $m is rw, Str:D $n is rw --> Bool:D) {
    my $s = $m ~ $n;
    return True if $N eq $s;
    return False unless $N.starts-with($s);

    $N .= substr($s.chars);
    ($m, $n) = ($n, $m + $n);
    while $N {
        ($m, $n) = ($n, $m + $n);
        return False unless $N.starts-with($m);

        $N .= substr($m.chars);
    }

    True
}

my $M = $N;
for 2..max(2, (($M.chars - 1) div 2)) -> $i {
    for 1..($i-1) -> $j {
        my $m = $M.substr(0, $j);
        my $n = $M.substr($j, $i - $j);
        if is-additive($M, $m, $n) {
            put 'true';
            exit 0;
        }
    }
}

put 'false';
