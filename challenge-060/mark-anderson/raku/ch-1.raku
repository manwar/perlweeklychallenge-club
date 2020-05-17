#!/usr/bin/env raku

sub from-excel(Str $str) {
    my $num;

    my @letters = $str.comb;

    my $exp = @letters.keys.max;

    for @letters {
        $num += ($_.ord - 64) * (26 ** $exp--);
    }    

    $num;
}

sub to-excel(UInt $num is copy) {
    my $string;
    my $quotient;
    my $remainder;
    my @letters = ("A" .. "Z");

    while $num > 26 {
        $quotient = ($num / 26).Int;
        $remainder = $num % 26;
    
        if $remainder == 0 {
            $quotient--;
            $remainder = 26;
        }

        $string ~= @letters[$remainder - 1];
        $num = $quotient;
    }

    $string ~= @letters[$num - 1];
    $string.flip;
}

multi sub MAIN (Str $str where $str ~~ /^<[A..Z]>+$/) {
    say from-excel($str);
}

multi sub MAIN (UInt $num where $num > 0) {
    say to-excel($num);
}
