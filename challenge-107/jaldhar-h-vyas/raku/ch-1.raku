#!/usr/bin/raku

sub is_harshad(Str $n) {
    return $n % $n.comb.sum == 0;
}

sub is_sdn(Str $n) {
    if !is_harshad($n) {
        return False;
    }

    my @digits = $n.comb;

    my %count;
    for 0 ..^ @digits.elems -> $i {
        %count{ @digits[$i] }++;
    }

    for 0 ..^ @digits.elems -> $i {
        if %count{$i}:!exists {
            next;
        }
        if %count{$i} != @digits[$i] {
            return False;
        }
    }

    return True;
}

sub MAIN() {
    my @sdns;

    for 4 .. 5 -> $base {
        for 10 ** ($base - 2) ..^ 10 ** ($base - 1) -> $i {
            my $n = $i.base($base);
            if is_sdn($n) {
                @sdns.push($n);
            }
            if (@sdns.elems == 3) {
                last;
            }
        }
    }

    @sdns.join(q{, }).say;
}