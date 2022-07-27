# Unoptimized version, don't use it
my $count = 0;
for 2..Inf -> $n {
    print "$n " and $count++ if is-perfect-totient $n;
    last if $count >= 20;
}
say "";
sub is-perfect-totient ($num) {
    my $n = $num;
    my $sum = 0;
    while $n >= 1 {
        $n = (grep { $n gcd $_ == 1 }, 1..^$n).elems;
        $sum += $n;
    }
    return $num == $sum;
}
