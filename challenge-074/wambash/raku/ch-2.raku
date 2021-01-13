use v6;

sub infix:<FNR> (+@a) is assoc<list> {
    @a.first: * ∉ @a.repeated, :end orelse '#'
}

sub FNR-charakter ( $s ) {
    [~] [\FNR] $s.comb
}

sub MAIN ( :$test ) {
    use Test;
    is 'a' FNR 'b' FNR 'c' FNR 'a', 'c';
    is FNR-charakter('ababc'), ‘abb#c’;
    is FNR-charakter('xyzzyx'), ‘xyzyx#’;
    done-testing();
}
