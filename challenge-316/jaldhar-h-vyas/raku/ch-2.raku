#!/usr/bin/raku

sub MAIN(
    $str1,
    $str2
) {
    my $match = $str1.comb.join(q{.*});
    say $str2.match(/<$match>/).so;
}
