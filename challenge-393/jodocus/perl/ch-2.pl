#!/usr/bin/perl
use warnings;
use strict;

# Task 2: Prime Steps
# You are given a string with English alphabetic characters only. What is the absolute difference
# of the sum of the ASCII values of the characters in the string to the nearest prime number?

my $string;

if (@ARGV) {
    $string = shift;
} else {
    print "Enter a string (only English alphabetic characters allowed): ";
    $string = <STDIN>;
    chomp($string);
}
die "No string provded!\n" unless ($string);

my @letters = split('', $string);
my $value = 0;
for (@letters) {
    die "Only one word allowed.\n" if (/\s/);
    die "Invalid character $_; only English alphabetic characters (a-z, A-Z) allowed!\n" unless (/[a-zA-Z]/);
    $value += ord($_);
}
print "The word $string has the value $value.\n";
if (&is_prime($value)) { print("$value is already prime!\n"); exit; }

my $difference = 0;
my $result;
while (1) {
    $difference++;
    for ($value - $difference, $value + $difference) {
    	if (&is_prime($_)) {
    		if ($result) { $result = "$result or $_"; }
    		else { $result = $_ };
    	}
    }
    if ($result) {
    	print "The difference to the nearest prime number ($result) is $difference.\n";
    	exit
    }
}
die "Program escaped loop somehow...?\n";

sub is_prime() {
    my $number = shift;
    return 0 unless ($number % 2);
    my $divisor = 3;
    while ($divisor ** 2 <= $number) {
    	return 0 unless ($number % $divisor);
    	$divisor += 2;
    }
    return 1;
}

