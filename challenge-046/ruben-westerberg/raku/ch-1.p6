#!/usr/bin/env perl6

my @inComming=(
	qw"P + 2 l ! a t o",
	qw"1 e 8 0 R $ 4 u",
	qw"5 - r ] + a > /",
	qw"P x w l b 3 k \\",
	qw"2 e 3 5 R 8 y u",
	qw"< ! r ^ ( ) k 0"
);
my @decoded;
for (0..@inComming[0]-1) {
	
	my $col=@inComming[0..@inComming-1;$_].Bag.grep({$_.value==2});
	@decoded.push: $col>>.key;;
}
put @decoded.join: "";
