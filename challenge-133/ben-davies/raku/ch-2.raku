use v6;
unit sub MAIN() {
    .say for (1..*).hyper.grep(*.&is-smith-number: 10).head(10);
}
sub is-smith-number(Int:D $x, Int:D $base) {
    not $x.is-prime and $x.&digits($base).sum == $x.&prime-factors».&digits($base).flat.sum
}
sub digits(Int:D $x, Int:D $base) {
    $x.polymod($base xx $x.log: $base).reverse
}
sub prime-factors(Int:D $x is copy) {
    state Int:D @primes = (2..*).grep(*.is-prime);
    gather $x div= take @primes.first($x %% *) while $x > 1
}
