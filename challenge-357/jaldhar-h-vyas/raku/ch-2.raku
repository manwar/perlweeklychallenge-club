#!/usr/bin/raku

sub MAIN(
    $int
) {
    ((1 .. $int) X (1 .. $int))
        .map({ my $gcd = $_[0] gcd $_[1]; [$_[0] / $gcd, $_[1] / $gcd] })
        .sort({ $^a[0] / $^a[1] <=> $^b[0] / $^b[1] })
        .map({ "$_[0]/$_[1]" })
        .unique
        .join(", ")
        .say;
}
