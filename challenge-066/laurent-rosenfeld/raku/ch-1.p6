use v6;

sub MAIN (Int $m is copy, $n is copy where $n != 0) {
    my $neg = ($m <0 && $n >0 or $m > 0 && $n < 0) ?? True !! False;
    $_ = .abs for $m, $n;
    my $quotient = 0;
    while $m > $n {
        $m -= $n;
        $quotient++;
    }
    $quotient = -$quotient if $neg;
    say $quotient;
}
