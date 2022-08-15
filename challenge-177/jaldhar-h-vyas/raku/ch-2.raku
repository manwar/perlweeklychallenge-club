#!/usr/bin/raku

sub isPalindromicPrimeCyclops(Int $n) {
    return $n.is-prime && $n == $n.flip && $n.substr($n.chars / 2, 1) == 0;
}

sub MAIN() {
    my @ppc;
    my $n = 101;

    while @ppc.elems <= 20 {
        if isPalindromicPrimeCyclops($n) {
            @ppc.push($n);
        }

        $n += 2;
    }

    @ppc.join(q{, }).say;
}