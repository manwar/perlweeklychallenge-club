#!/bin/env perl6

sub d2r(Int $i where 0 <= * <= 9, Str $c1, Str $c5, Str $c10) returns Str {
    given ($i) {
        when (9)         { return $c1 ~ $c10 }
        when (* ~~ 5..8) { return $c5 ~ $c1 x ($i - 5) }
        when (4)         { return $c1 ~ $c5 }
        when (* ~~ 0..3) { return $c1 x $i }
    }
}

multi sub MAIN(Str $p where * ~~ /^ <[IVXLCDM]>+ $/) {
    my %r2a = 'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000;
    my @a = $p.comb.map:{ %r2a{ $_ } };

    my $sum = [+] (0 .. (@a.elems - 2)).map:{ @a[$_] < @a[$_ + 1] ?? -@a[$_] !! @a[$_] };
    $sum += @a[* - 1];

    say $sum;
}

multi sub MAIN(UInt $p) {
    my Str $s = 'M' x ($p div 1000);
    my Int $n = $p mod 1000;

    $s ~= d2r($n div 100, 'C', 'D', 'M');
    $n %= 100;

    $s ~= d2r($n div 10, 'X', 'L', 'C');
    $s ~= d2r($n mod 10, 'I', 'V', 'X');

    say $s;
}
