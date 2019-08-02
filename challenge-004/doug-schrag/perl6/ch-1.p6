use v6;

my $chars = $*PROGRAM.slurp.chars;
say pi-rat.Str.substr(0,$chars);
say "$chars digits!";

sub postfix:<!> ($n) { [*] 1..$n }
sub f($k) {
    FatRat.new: (4*$k)! * (1103 + 26390 * $k), ($k!)**4 * 396**(4*$k)
}
sub pi-rat () {
    9801 * sqrt-rat(2, 1e-500) / 4
    / [+] (^80).map: *.&f
}

multi sub sqrt-rat ($n where * > 0, $eps) {
    my $base = $n.FatRat($eps);
    my $r = sqrt($base).FatRat($eps);
    my $est;
    repeat {
        $est = $r;
        $r = ($base / $est + $est) / 2;
    } while abs($r - $est) > $eps;

    return $r;
}
multi sub sqrt-rat (0) { 0 }
