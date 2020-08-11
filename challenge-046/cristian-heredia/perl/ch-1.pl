#!/usr/bin/perl

use strict;
use warnings;

#First, we write the message into arrays:
my @array1 = ('P',  '+',  '2',  'l',  '!',  'a',  't',  'o' );
my @array2 = ('1',  'e',  '8',  '0',  'R',  '$',  '4',  'u' );
my @array3 = ('5',  '-',  'r',  ']',  '+',  'a',  '>',  '/' );
my @array4 = ('P',  'x',  'w',  'l',  'b',  '3',  'k',  '\\' );
my @array5 = ('2',  'e',  '3',  '5',  'R',  '8',  'y',  'u' );
my @array6 = ('<',  '!',  'r',  '^',  '(',  ')',  'k',  '0' );

my @arrayCharacter;

print "The message is: ";
foreach (my $i = 0; $i < @array1; $i++) {

	@arrayCharacter = ();
	push(@arrayCharacter, @array1[$i]);
	push(@arrayCharacter, @array2[$i]);
	push(@arrayCharacter, @array3[$i]);
	push(@arrayCharacter, @array4[$i]);
	push(@arrayCharacter, @array5[$i]);
	push(@arrayCharacter, @array6[$i]);
	
	my %count;
	$count{$_}++ foreach @arrayCharacter;

	#removing the lonely strings
	while (my ($key, $value) = each(%count)) {
		if ($value == 1) {
			delete($count{$key});
		}
	}

	#output the counts
	while (my ($key, $value) = each(%count)) {
		print "$key";
	}
}






