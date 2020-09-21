use Bench;

my $n = @*ARGS[0] || 42;

#say i($n);
#say r($n);
#say f($n);
#say k($n);
#say l($n);

sub i {
    +$^n.base(2).indices(1) }

sub r {
    +($^n.base(2) ~~ m:g/1/) }

sub f {
    $^n == 0 ?? 0 !! $^n !%% 2 + f( $^n div 2 ) }

sub k($n is copy) {
    my $c = 0; while $n != 0 { $n = $n +& ($n-1); $c++ }; $c }

sub l {
    state @b = 0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4;
    $^n == 0 ?? 0 !! @b[ $^n +& 0xf ] + l($^n +> 4) }

Bench.new.timethese( 100000, {
    base2-with-indices => { i(42) },
    base2-with-regex   => { r(42) },
    div2-recursive     => { f(42) },
    kernighan          => { k(42) },
    lookup-recursive   => { l(42) }})