#!/usr/bin/perl6

sub perfectCandidate(Int $p) {

    my $q = 2 ** $p - 1;
    return $q * ($q + 1) div 2;
}

sub isPerfect(Int $number) {

    my $total = 0;
    for 1 .. $number -> $i {
        if $number %% $i {
            $total += $i;
        }
    }

    return ($total / 2  == $number);
}

multi sub MAIN() {
    my Int @perfects;
    my Int $n = 1;

    while @perfects.elems < 5 {
        my $number = perfectCandidate($n);
        if (isPerfect($number)) {
            push @perfects, $number;
        }
        $n++;
    }

    @perfects.join(' ').say;
}
