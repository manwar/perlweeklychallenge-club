sub fact($n) {
    return 1 if $n == 1;
    return $n*fact($n-1);
}

sub comb($n, $r) {
    return fact($n) / (fact($n-$r) * fact($r));
}

sub B($n, $k) {
    return comb($n, $k) * N($n-$k);
}

sub N($n) {
    return 0 if $n == 1;
    my $bad = 1;
    $bad += B($n, $_) for (1 .. $n-2);
    return fact($n) - $bad;
}


sub proc($n) {
    say "Input: $n";
    say "Output: ", N($n);
}

my $n = 1;
proc($n);
$n = 2;
proc($n);
$n = 3;
proc($n);
$n = 4;
proc($n);
$n = 5;
proc($n);
