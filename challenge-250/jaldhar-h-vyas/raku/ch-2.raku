#!/usr/bin/raku

sub MAIN(
    *@alphanumstr
) {
    my $maxvalue = -∞;

    for @alphanumstr -> $str {
        my $value = ($str ~~ /^ \d+ $/) ?? $str.base(10) !! $str.chars;
        if $value > $maxvalue {
            $maxvalue = $value;
        }
    }

    say $maxvalue;
}