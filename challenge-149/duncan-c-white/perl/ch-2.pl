#!/usr/bin/perl
# 
# TASK #2 - Largest Square
# 
# Given a number base, derive the largest perfect square with no repeated
# digits and return it as a string. (For base>10, use 'A'..'Z'.)
# 
# Example:
# 
#     f(2)="1"
#     f(4)="3201"
#     f(10)="9814072356"
#     f(12)="B8750A649321"
# 
# 
# MY NOTES: Obvious technique is to compute all permutations of 0..B-1 (B the
# base), and check whether each is a perfect square, and track the largest
# perfect square we find.  I hate permutations, but I'm sure I have written
# a permutation generator in previous Perl Challenges...  Oh yes, stolen
# code from Challenge 134 (task 1) and made it into a simple Perms module here.
# This code is quite slow for bases > 8, probably needs profiling led
# optimization but I haven't got the time.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

use lib qw(.);
use Perms;

my $debug=0;

die "Usage: largest-square-in-base-B [--debug] B\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $base = shift;

die "base $base out of range 2..36\n" if $base<2 || $base>36;


#
# my $ispq = is_perfect_square( $n );
#	Return 1 iff $n is a perfect square; return 0 otherwise.
#
fun is_perfect_square( $n )
{
	my $sqrt = int(sqrt($n));
	return $sqrt*$sqrt == $n ? 1 : 0;
}


my @digits = (0..9, 'A'..'Z');
my %digpos = map { $digits[$_] => $_ } 0..$#digits;
#die Dumper( \%digpos );


#
# my $v = base_value($x,$base);
#	Given a base $base (2..36) string $x, calculate
#	it's integer value and return it.  eg bv("FF",16)==255
#
fun base_value( $x, $base )
{
	my $v = 0;
	if( $x )
	{
		$x =~ /^(.*)(.)$/;
		$x = $1;
		my $d = $2;
		$v = base_value( $x, $base );
		$v *= $base;
		$v += $digpos{$d};
	}
	return $v;
}


my $perm = join('', map { $digits[$_] } 0..$base-1 );
#say $perm;
#say base_value($perm,$base);
#exit 0;

my $maxval = 0;
my $maxperm = 0;

do {
	say "perm=$perm, maxvalsofar=$maxval, maxpermsofar=$maxperm" if $debug;
	my $v = base_value($perm,$base);
	if( is_perfect_square($v) )
	{
		say "perm $perm (value $v) is a perfect square" if $debug;
		if( $v>$maxval )
		{
			say "new max val $v, perm $perm" if $debug;
			$maxval = $v;
			$maxperm = $perm;
		}
	}
	$perm = Perms::next_perm($perm);
} while defined $perm;

say $maxperm;
