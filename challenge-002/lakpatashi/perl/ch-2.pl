#!/usr/bin/perl

use strict;
use warnings;

#	PART 2
use List::Util qw(min max sum);
use Data::Dumper qw(Dumper);
my %digit;
my @keys = ( (0..9),('A'..'Y') );
my @values = (0..35);
@digit{@keys}=@values;
my %digitRev = reverse %digit;
#print Dumper \%digitRev;

my $num1 = 'A1K3';
print "Given base35 no:: $num1\n";
print "converted to int no:: ",intToBase35($num1),"\n";

my $num2 = 430678;
print "Given int no:: $num2\n";
print "converted to base35 no:: ",base35ToInt($num2),"\n";


sub intToBase35{
	my @num = split '', shift;
	@num = reverse @num;
	@num = map { $digit{$num[$_]} * 35**$_ }  0..$#num ;
	return sum @num;
}

sub base35ToInt{
	my $num = shift;
	my @arr;
	while($num > 35){
		unshift @arr, $num%35;
		$num = int($num/35);
	}
	unshift @arr, $num;
	@arr = map { $digitRev{$_} }  @arr;
	return join '',@arr;
}
