#!/usr/env perl
# VIN translator Problem
use strict;
use warnings;

# usage: VINValidator($VINundertest,[verbosity]);
# 1st parameter is VIN to test, second paramete is verbosity required
# returns 1 for valid or 0 for invalid
# if verbose parameter resolves to true, the success or failure (with reason) 
# is printed to console 

sub VINValidator{
	my ($input,$verbose)=@_;   
	if (length($input)!=17) {             # VINS must have 17 characters
		print "$input is invalid: VIN must be 17 characters\n" if ($verbose);
		return 0;
		};
	$input=uc($input);
	if ($input=~m/([IOQ]|[^A-Z\d_])/)  {  # VINS must be alphanumeric excluding IOQ
		print "$input is invalid: Invalid character '$1' found\n"  if ($verbose);
		return 0;
		 };
	my $check_digit=substr($input,8,1);   # the 9th character represents the Check Digit
	(my $trans=$input)=~tr/A-Z/1-8 1-5 7 92-9/;  #Transliteration of characters
	my @values=split //,$trans;     # convert to array of digits
	my $sum=0;
	for my $pos (1..17){            # multipler can be obtained using $pos==8?10:9-$pos%10
		$sum+=($pos==8?10:9-$pos%10)*$values[$pos-1];  
	}
	my $check_sum=$sum%11;          # check digit should be $sum modulo 11, and "X" if it is 10
	$check_sum="X" if ($check_sum>9);
	if ($check_digit ne $check_sum)  {
		print "$input is invalid: Invalid CheckDigit $check_digit; calculated $check_sum\n" if ($verbose);
		return 0;
		};
	print "$input is a valid VIN\n" if $verbose;
	return 1;
}


# tests the subroutine

my @ValidVINS=(           # obtained from Random VIN Generator @ https://randomvin.com/
    "2HGFG11628H511085",
    "1HD1FC4107Y692634",
    "1G4CW54K614187447",
    "1FMDU34X7RUB06879",
    "1G1ZB5E06CF321106");

my @InvalidVINS=(
    "1G4CW54K61418Q447",  # invalid character
    "1FMDU34X7RUB0679",   # only 16 characters
    "1G1Z35E06CF321106"); # invalid checksum

for (@ValidVINS,@InvalidVINS){
	VINValidator($_,1)
}
