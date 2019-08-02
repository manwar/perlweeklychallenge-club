#!/usr/bin/perl -w
use strict;
use v5.10;
=pod

=head1 Perl Weekly Challenge #002-2
 Write a script that can convert integers to and from a base35 representation, using the characters 0-9 and A-Y.
 note: argument checking is not completely safe, was not part of the solution.

=cut

unless((scalar(@ARGV)==2) && ($ARGV[0] =~/tobase35|frombase35/)){
say <<USAGE;
usage: chw2_2.pl <options>
	tobase35   - convert decimal integer to base35
	frombase35 - convert base35 number to decimal
        number 
examples: 	chw2_2.pl tobase35 256, should print '7b'
		chw2_2.pl frombase35 7b, should print '256'
USAGE
exit;
} 

my $string="";
my $demal = 0;

process($ARGV[0],$ARGV[1]); 

sub process {
my ($option, $number) = @_;
if ($option eq "tobase35") {
	$number = int($number);
	while($number){
		$string .= ('0'..'9','A'..'Z')[$number % 35];
		$number = int($number/35);
	}
say scalar(reverse($string));
}
else {
	$number = uc($number);
	for my $char (split(//,$number)){
	$demal = 35*$demal + index("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",$char);
	}
say $demal;
}
}
exit;	

