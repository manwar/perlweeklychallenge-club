#!/usr/bin/env raku

sub from-excel(Str $str) {
    my $num;

    my @letters = $str.comb;

    my $exp = @letters.keys.max;

    for @letters {
        $num += (.ord - 64) * (26 ** $exp--);
    }    

    $num;
}

sub to-excel(UInt $num is copy) {
    my $string;
    my $remainder;
    my @letters = ("A" .. "Z");

    while $num > 26 {
        $remainder = $num mod 26;
        $num div= 26;
    
        if $remainder == 0 {
            $remainder = 26;
            $num--;
        }

        $string ~= @letters[$remainder - 1];
    }

    $string ~= @letters[$num - 1];
    $string.flip;
}

multi sub MAIN (Str $str where $str ~~ /^ <[A..Z]>+ $/) {
    say from-excel($str);
}

multi sub MAIN (UInt $num where $num > 0) {
    say to-excel($num);
}
