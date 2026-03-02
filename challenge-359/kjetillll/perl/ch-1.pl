sub f {
    my($n, $p) = @_;
    length($n) > 1 ? f( eval(join'+',split//,$n), $p + 1 ) : ( $p//0, $n )
}
my @tests = (
    [ 38         => 2, 2 ],
    [ 7          => 0, 7 ],
    [ 999        => 2, 9 ],
    [ 1999999999 => 3, 1 ],
    [ 101010     => 1, 3 ],
);
print join(',',f(shift@$_)) eq join(',',@$_) ? "ok\n" : "ERROR\n" for @tests;
