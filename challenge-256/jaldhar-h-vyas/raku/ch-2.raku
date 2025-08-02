#!/usr/bin/raku

sub MAIN(
    Str $str1,
    Str $str2
) {
    my $remainder = '';

    if $str1.chars < $str2.chars {
        $remainder = $str2.comb.Array.splice($str1.chars, *).join;
    } elsif $str1.chars > $str2.chars {
        $remainder = $str1.comb.Array.splice($str2.chars, *).join;
    }
    say ($str1.comb Z~ $str2.comb).join ~ $remainder;
}