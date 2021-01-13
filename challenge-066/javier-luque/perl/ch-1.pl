#!/usr/bin/perl
# Test: ./ch-1.pl
use Modern::Perl;
use List::Util qw/sum/;
use Test::More;

is (divide(5,2),   2,  'Divide 5 , 2');
is (divide(-5,2), -3,  'Divide -5 , 2');
is (divide(-5,-2), 2,  'Divide -5 , -2');
done_testing();

sub divide {
    my ($M, $N) = @_;
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

    return ($negative) ?
    	- $quotient - 1 : $quotient;
}
