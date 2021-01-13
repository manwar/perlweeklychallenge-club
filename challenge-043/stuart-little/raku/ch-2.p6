#!/usr/bin/env perl6
use v6;

# run as <script> <base>

sub self_desc($b where * >= 2) {
    $b == (1,2,3,6).any && return "None" xx 2;
    my $b10=($b-4) * $b ** ($b-1)
    + 2 * $b ** ($b-2)
    + $b ** ($b-3)
    + $b ** 3;
    $b10, (($b <= 36) ?? ($b10.base($b)) !! ("base too large"))
}

my $base=@*ARGS[0];
printf("Base 10: %s\nBase {$base}: %s\n", |self_desc($base))
