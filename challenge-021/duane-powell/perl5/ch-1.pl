#!/usr/bin/perl
use Modern::Perl;
use bignum qw(e);
use Math::BigFloat;
Math::BigFloat->precision(-50);

# write a script to calculate e https://en.wikipedia.org/wiki/E_(mathematical_constant)
# e, Euler's number, 2.71828182845904523536028747135266249775724709369995

sub factorial {
	my $f = 1;
	map { $f *= $_ } ( 1 .. shift );  
	return $f;
}

sub e_factorial {
	my $e = 0;
	map { $e += 1/factorial($_) } ( 0 .. shift );
	return $e;
}

sub brothers {
	my $b = 0; 
	map { $b += (2 * $_ + 2) / factorial(2 * $_ + 1) } ( 0 .. shift );
	return $b;
}

sub e_brothers {
	my $b = shift;
	my $e = brothers($b);
	return $e;
}

sub e_limit_n {
	my $n = shift;
	return ( 1 + 1/$n ) ** $n;
}

sub e_limit_t {
	my $t = shift;
	return ( 1 + $t ) ** (1/$t);
}


my $e = 2.71828182845904523536028747135266249775724709369995;
say $e, " e constant from wiki";

$e = e(); 
say $e, " e from perl module bignum";

my $n = 40;
$e = e_factorial($n);
say $e, " e calculated from $n factorial";

$n = 20;
$e = e_brothers($n);
say $e, " e calculated from brothers, $n steps";

$n = 100000;
$e = e_limit_n($n);
say $e, " e calculated as a limit n approaching infinity $n";

$n = .00001;
$e = e_limit_t($n);
say $e, " e calculated as a limit t approaching zero $n";


__END__

./ch1.pl
2.71828182845904523536028747135266249775724709369995 e constant from wiki
2.71828182845904523536028747135266249775700000000000 e from perl module bignum
2.71828182845904523536028747135266249775724709369992 e calculated from 40 factorial
2.71828182845904523536028747135266249775724709369997 e calculated from brothers, 20 steps
2.71826823717448966803506482442604644797444693267782 e calculated as a limit n approaching infinity 100000
2.71826823717448966803506482442604644797444693267782 e calculated as a limit t approaching zero 0.00001

