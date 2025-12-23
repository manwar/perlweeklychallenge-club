#!/usr/bin/raku

sub isFibonacci($n) {
    return isPerfectSquare(5 * $n² + 4) || isPerfectSquare(5 * $n² - 4);
}

sub isPerfectSquare($n) {
    my $s = $n.sqrt.Int;
    return $s² == $n;
}

sub MAIN(
    Int $N
) {
    my @sums;
    my $n = 0;
    my $count = $N;

    while $count {
        if isFibonacci( $n.comb.sum ) {
            @sums.push($n);
            $count--;
        }
        $n++;
    }

    @sums.join(q{, }).say;
}