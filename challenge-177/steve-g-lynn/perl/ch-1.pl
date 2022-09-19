#!/usr/bin/env perl

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

print &get_check_digit(572),"\n"; #4
print &validate(5724),"\n"; #1
print &validate(5727),"\n"; #0

sub get_check_digit {
	my ($n)=@_;
	my @n=split //,$n;
	my $interim = 0;
	for my $digit (@n) {
		$interim = ( split //, ($quasigroup_111[$interim]) )  [$digit];
	}
	return $interim;
}

sub validate {
	my ($n)=@_;
	my $interim = get_check_digit ($n);
	return ( ($interim == 0) ? 1 : 0);
}

