#!perl
use v5.32;

sub flip_integer {
    my $n = shift;
    my $sign = $n < 0 ? -1 : 1;
    my $o = $sign * reverse(abs($n));
    return (-2**31 <= $o < 2**31) ? $o : 0;
}

for my $n (@ARGV) {
    my $o = flip_integer($n);
    say "$n -> $o";
}
