#!/usr/bin/env raku

our @quasigroup_111 = (
	'0317598642',
	'7092154863',
	'4206871359',
	'1750983426',
	'6123045978',
	'3674209581',
	'5869720134',
	'8945362017',
	'9438617205',
	'2581436790'
);

say get_check_digit(572); #4
say validate(5724); #True
say validate(5727); #False

sub get_check_digit (Int $n) {
	my @n=$n.comb;
	my $interim = 0;
	for (@n) -> $digit {
		$interim = (  ( @quasigroup_111[$interim] ).comb  )[$digit];
	}
	return $interim;
}

sub validate (Int $n) {
	my $interim = get_check_digit ($n);
	return ($interim == 0);
}
