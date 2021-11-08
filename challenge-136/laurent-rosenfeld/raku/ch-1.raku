use v6;

sub is-friendly (Int $i, Int $j) {
    my $gcd = $i gcd $j;
    return 0 if $gcd <= 1;
    $gcd /= 2 while $gcd %% 2;
    return $gcd == 1 ?? 1 !! 0;
}
for 8, 24, 26, 39, 4, 10, 7, 5, 18, 0 {
    say "$^a, $^b => ", is-friendly $^a, $^b;
}
