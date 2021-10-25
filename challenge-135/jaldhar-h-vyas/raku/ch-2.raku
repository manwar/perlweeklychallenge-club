#!/usr/bin/raku

sub check(Str $sedol) {
    if ($sedol.chars != 7) {
        return False;
    }

    if ($sedol !~~ /^ <[0..9] + [A..Z] - [AEIOU]> ** 6 <[0..9]> $ /) {
        return False;
    }

    my @weights = (1, 3, 1, 7, 3, 9, 1);

    my @chars = $sedol.comb;

    my $sum = 0;

    for 0 .. 5 -> $i {
        if (@chars[$i].ord >= '0'.ord && @chars[$i].ord <= '9'.ord) {
            $sum += @chars[$i] * @weights[$i];
        } else {
            $sum += (@chars[$i].ord - 'A'.ord) * @weights[$i];
        }
    }

    return ((10 - $sum % 10) % 10) == @chars[6];
}

sub MAIN(
    Str $sedol #= seven character string
) {
    say check($sedol) ?? '1' !! '0';
}
