#!/usr/bin/env raku

sub MAIN(
    Str $str
) {
    my @letters = $str.comb.grep({ /<lower>/ }).sort;
    my @digits = $str.comb.grep({ /<digit>/ }).sort;
    my $digitFirst = @digits.elems >= @letters.elems;

    if (@letters.elems - @digits.elems).abs > 1 {
        say "";
        exit;
    }

    my $result = "";
    my $lindex = 0;
    my $dindex = 0;

    while $lindex < @letters.elems || $dindex < @digits.elems {
        if $digitFirst {
            if $dindex < @digits.elems {
                $result ~= @digits[$dindex++];
            }
            if $lindex < @letters.elems {
                $result ~= @letters[$lindex++];
            }
        } else {
            if $lindex < @letters.elems {
                $result ~= @letters[$lindex++];
            }
            if $dindex < @digits.elems {
                $result ~= @digits[$dindex++];
            }
        }
    }

    say $result;
}