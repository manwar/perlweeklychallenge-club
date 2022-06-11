sub is_factorion (Int $in) {
    my $sum = [+] map { [*] 1..$_ }, $in.comb;
    return $sum == $in;
}
say $_ if is_factorion $_ for 1..50000;
