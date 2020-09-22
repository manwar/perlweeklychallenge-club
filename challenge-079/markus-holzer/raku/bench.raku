use Bench;
use experimental :cached;

unit sub MAIN(Int $N = 42);

#say ($N...1).map( &i ).sum;
#say ($N...1).map( &r ).sum;
#say (1..$N).map( &f ).sum;
#say (1..$N).map( &k ).sum;
#say ($N...1).map( &l ).sum;
#say a($N);
#say b($N);
#exit;
sub i {
    +$^n.base(2).indices(1) }

sub r {
    +($^n.base(2) ~~ m:g/1/) }

sub f is cached {
    $^n == 0 ?? 0 !! $^n !%% 2 + f( $^n div 2 ) }

sub k($n is copy) is cached {
    my $c = 0; while $n != 0 { $n = $n +& ($n-1); $c++ }; $c }

sub l is cached {
    state @b = 0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4;
    $^n == 0 ?? 0 !! @b[ $^n +& 0xf ] + l($^n +> 4) }

sub a($n) {
    my @scale = (1, 2 * * ...^ * > $n);
    my $total-bits = 0;

    for @scale -> $pwr {
        my $fill = ($n + 1) / (2 * $pwr);
        my $max = $pwr * 2;

        my $fill-full = $fill.Int;
        my $fill-frac = $fill - $fill-full;

        my $bits-full = $fill-full * $pwr;
        my $bits-frac = 0;

        if $fill-frac > 0.5 {
            $bits-frac = ($fill-frac - 0.5) * $max;
     #       say "($fill-frac - 0.5) * $pwr" if $verbose;
        }

        my $bits = $bits-full + $bits-frac;
      #  say "bits-full=$bits-full, bits-frac=$bits-frac, bits=$bits" if $verbose;

        $total-bits += $bits;
    }

    $total-bits;
}

sub b(Int $N)
{
    my Int $t = 2;
    my Int $r = 0;
    my Int $n = $N;

    while $n {
        my $a = $t +> 1;
        my $s = $N +& ( $t - 1);
        my $d = ( $N div $t );

        $r += $d * $a;
        $r += $s - $a + 1 if $s > $a - 1;
        $t = $t +< 1;
        $n = $n +> 1;
    }

    return $r
}

Bench.new.timethese( 1000, {
    ash                => { a($N) },
    holli              => { b($N) },
#    base2-with-indices => { ($N...1).map( &i ).sum },
#    base2-with-regex   => { ($N...1).map( &r ).sum },
#    div2-recursive     => { ($N...1).map( &f ).sum },
#    kernighan          => { ($N...1).map( &k ).sum },
#    lookup-recursive   => { ($N...1).map( &l ).sum }
})git