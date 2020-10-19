sub common_factors (Int $a, Int $b) {
    my $gcd = $a gcd $b;
    return (1,) if $gcd == 1;
    return ($gcd,) if $gcd.is-prime;
    return (1..$gcd).grep($gcd %% *).unique;
}
my @result = common_factors 12, 18;
say @result;
