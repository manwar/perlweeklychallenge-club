#!/usr/bin/raku

sub MAIN(
    Str $str
) {
    my @digits = $str.comb;
    my $checksum = @digits.pop;
    my $sum;

    for @digits.keys.reverse -> $k {
        if @digits[$k] !~~ '0' .. '9' {
            next;
        }
        my $val = $k % 2 ?? @digits[$k] * 2 !! @digits[$k];
        $sum += $val > 9 ?? $val.comb.sum !! $val;
    }

    say 10 - $sum % 10 == $checksum;
}