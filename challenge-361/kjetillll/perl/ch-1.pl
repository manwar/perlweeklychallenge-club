use List::Util qw(max);

my @fib = (1,1);

sub f {
    my $n = shift;
    push @fib, $fib[-1] + $fib[-2] while $fib[-1] < $n;
    my $f = max grep $_ <= $n, @fib;
    $n > 0 ? ( $f, f($n-$f) ) : ();
}

my @tests = (
    [ 4    => 3,1],
    [ 12   => 8,3,1],
    [ 20   => 13,5,2],
    [ 96   => 89,5,2],
    [ 100  => 89,8,3],
    [ 12345678910 => 7778742049,2971215073,1134903170,433494437,24157817,
                     2178309,832040,121393,28657,4181,1597,144,34,8,1 ]
);
for(@tests){
    my $n = shift @$_;
    my $want = join '+', @$_;
    my $got  = join '+', f($n);
    print
        $want eq $got
        && eval($got) == $n
        ? "ok\n" : "ERROR $got\n";
}
