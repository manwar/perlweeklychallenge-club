#!/usr/bin/perl
use strict;

my $numberoflines = 6;
my $msglength = 8;
my @charoccurence;

for my $i (0..$numberoflines-1) {
	for my $j (0..$msglength-1) {
		for my $d (33..126) {
			$charoccurence[$j][$d] = 0;  # ref to the ASCII table; #33 is ! and #126 is ~
		}
	}
}



my $msg = 'P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0';

# " =~ s/\s//g " isn't good becoz it removes new line characters
$msg =~ s/\h//g;

my @lines = split("\n", $msg);


for my $i (0..$numberoflines-1) {
	my  @str = split // , $lines[$i];
	for my $j (0..$msglength-1) {
		for my $d (33..126) {
			if (ord($str[$j]) == $d) {
			#			 if ( $str[$j] eq chr($d)) {
			#	 print chr($d);			 #testing 
				 $charoccurence[$j][$d]++;
			 } 
		}
	}
}


my $truth = "";

for my $j (0..$msglength-1) {
		for my $d (33..126) {
			if ($charoccurence[$j][$d] > 1 ) { $truth .= chr($d); } 
		}
}

print $truth;



# 1. read lines
# 2. find out the repeated characters
# 3. split(, / //g);
