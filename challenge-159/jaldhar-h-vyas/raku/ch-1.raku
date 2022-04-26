#!/usr/bin/raku

sub MAIN(
    Int $n #= a positive integer
) {
    my ($a, $b, $c, $d) = (0, 1, 1, $n);

    print "$a/$b ";
    while $c <= $n {
        my $k = ($n + $b) div $d;
        ($a, $b, $c, $d) = ($c, $d, $k * $c - $a, $k * $d - $b);
        print "$a/$b ";
    }
    print "\n";
}
