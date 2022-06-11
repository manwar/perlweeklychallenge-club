use Modern::Perl;
use experimental qw<signatures>;

# Using two key insights from https://wlmb.github.io/2022/03/07/PWC155/ ,
# this version only takes 4.4 seconds to recreate https://oeis.org/A001175/b001175.txt .
sub nth_Pisano_period ( $N ) {
    my ($n, $fib1, $fib2) = (0, 0, 1 % $N);

    my $fib2_original = $fib2;
    while (1) {
        ( $fib1, $fib2 ) = ( $fib2, ($fib1 + $fib2) % $N );
    	++$n;
        return $n if $fib1 == 0
                 and $fib2 == $fib2_original;
    }
    
}

die if join( ',', map { nth_Pisano_period($_) }  1 .. 20 )
    ne join( ',', (1,3,8,6,20,24,16,12,24,60,10,24,28,48,40,24,36,24,18,60) );

say $_, ' ', nth_Pisano_period($_) for 1 .. 10_000;
say '' for 1..7;
