#!/usr/bin/perl
use strict;

# Roman Calculator
# sample input: V + VI
# expected output: XI
# 
# allow only non-negative integers
# allowable operations of this script: +, -, *
# learn to use eval $string
# positive integers only

my %sk = (
	"I" => 1,
	"V" => 5,
	"X" => 10,
	"L" => 50,
	"C" => 100,
	"D" => 500,
	"M" => 1000
);


sub roman_to_dec {
	my $total = 0;
	my @char = split //, $_[0];
	
	for my $i (0..$#char-1) {
		$total += $sk{$char[$i]};	
		if ($sk{$char[$i]} < $sk{$char[$i+1]}) {
			$total = $total - 2*$sk{$char[$i]}; 
		}
	}
	$total += $sk{$char[$#char]};

	$total;
}


sub dec_to_roman {
	my $roman = "";
	my $temp = $_[0];

	while ($temp > 0) {
		if ($temp >= 1000) {
			$roman .= "M";
			$temp = $temp - 1000;
		}
		if ($temp >= 900 and $temp <= 999) {
			$roman .= "CM";
			$temp = $temp - 900;
		}
		if ($temp >= 500 and $temp <= 899) {
			$roman .= "D";
			$temp = $temp - 500;
		}
		if ($temp >= 400 and $temp <= 499) {
			$roman .= "DC";
			$temp = $temp - 400;
		}
		if ($temp >= 100 and $temp <= 399) {
			$roman .= "C";
			$temp = $temp - 100;
		}
		if ($temp >= 90 and $temp <= 99) {
			$roman .= "XC";
			$temp = $temp - 90;
		}
		if ($temp >= 50 and $temp <= 89) {
			$roman .= "L";
			$temp = $temp - 50;
		}
		if ($temp >= 40 and $temp <= 49) {
			$roman .= "XL";
			$temp = $temp - 40;
		}
		if ($temp >= 10 and $temp <= 39) {
			$roman .= "X";
			$temp = $temp - 10;
		}
		if ($temp == 9) {
			$roman .= "IX";
			$temp = $temp - 9;
		}
		if ($temp >= 5 and $temp <= 8) {
			$roman .= "V";
			$temp = $temp - 5;
		}
		if ($temp == 4) {
			$roman .= "IV";
			$temp = $temp - 4;
		}
		if ($temp >= 1 and $temp <= 3) {
			$roman .= "I";
			$temp = $temp - 1;
		}
	}
	$roman;

}

my $formula;

chomp($_ = <STDIN>);

if (/([A-Z]+)(\s*)([\+,\-,\*])(\s*)([A-Z]+)/) {
	$formula = roman_to_dec($1).$3.roman_to_dec($5);
}

my $result = eval $formula;       #IMPORTANT

print dec_to_roman($result), "\n"; 
