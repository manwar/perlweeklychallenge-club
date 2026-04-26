#!/usr/bin/raku

sub isScramble(Str $str1, Str $str2) {
    if $str1 eq $str2 {
        return True;
    }

    my $n = $str1.chars;
    for 1 ..^ $n -> $i {
        my $str1A = $str1.substr(0, $i);
        my $str1B = $str1.substr($i, $n - $i);

        my $str2A = $str2.substr(0, $i);
        my $str2B = $str2.substr($i, $n - $i);

        if isScramble($str1A, $str2A) && isScramble($str1B, $str2B) {
            return True;
        }

        my $str2AS = $str2.substr($n - $i, $i);
        my $str2BS = $str2.substr(0, $n - $i);

        if isScramble($str1A, $str2AS) && isScramble($str1B, $str2BS) {
            return True;
        }
    }

    return False;
}

sub MAIN(
    Str $str1,
    Str $str2
) {
    if $str1.chars != $str2.chars || $str1.comb.sort !~~ $str2.comb.sort {
        say False;
    } else {
        say isScramble($str1, $str2);
    }
}
