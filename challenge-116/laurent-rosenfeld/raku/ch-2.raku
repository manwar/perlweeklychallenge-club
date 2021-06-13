use v6;

sub sum-squares (Int $n where * >= 10) {
    my $sum-sq = [+] $n.comb.map({$_²});
    my $sqrt-int = $sum-sq.sqrt.Int;
    return $sqrt-int² == $sum-sq ?? 1 !! 0;
}
say "$_: ", sum-squares $_ for 10..71;
