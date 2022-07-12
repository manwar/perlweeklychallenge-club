sub is-esthetic ($n) {
    my @d = $n.comb;     # get an array of digits
    return False if abs(@d[$_] - @d[$_-1]) != 1 for 1..@d.end;
    return True;
}
for <5456 120 121 23456 2346 7654567 765467> -> $test {
    say $test.fmt("%-9d"), is-esthetic($test) ?? "is esthetic" !! "is not esthetic";
}
