# Test: perl6 ch-1.p6
use Test;

sub MAIN() {
    is divide(5,2),   2,  'Divide 5 , 2';
    is divide(-5,2), -3,  'Divide -5 , 2';
    is divide(-5,-2), 2,  'Divide -5 , -2';
    done-testing;
}

sub divide(Int $M is copy, Int $N is copy) {
    my $quotient = 0;
    my $negative = 0;

    if ($M < 0 && $N > 0) {
    	$negative = 1;
    	$M = - $M;
    } elsif ($M > 0 && $N < 0) {
    	$negative = 1;
    	$N = - $N;
    } elsif ($M < 0 && $N < 0) {
    	$M = - $M;
    	$N = - $N;
    }

    while ($M > $N) {
    	$M = $M - $N;
    	$quotient++;
    }

    return ($negative) ??
    	- $quotient - 1 !! $quotient;
}
