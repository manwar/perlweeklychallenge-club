#!/usr/bin/raku

multi sub multiply(
    Int $A,
    Int $B,
    Int $sum
    where { $A == 1 }
) {
    return $sum;
}

multi sub multiply(
    Int $A,
    Int $B,
    Int $sum is copy
   where { $A > 1 }
) {
    my $a = $A div 2;
    my $b = $B * 2;

    if $a % 2 {
        $sum += $b;
    }

    return multiply($a, $b, $sum);
}

sub MAIN(
    $A,
    $B
    where { $A > 0 && $B > 0}
) {
    say multiply($A, $B, $A % 2 ?? $B !! 0);
}