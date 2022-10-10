#!/usr/bin/perl
# 
# Task 2: Mask Code
# 
# You are given a list of codes in many random format.
# Write a script to mask first four characters (a-z,0-9) and keep the rest as it is.
# 
# Example 1
# 
# Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
# Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')
# 
# Example 2
# 
# Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
# Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')
# 
# MY NOTES: Also seems pretty simple.  Decided to generalise: --firstn N
# does the masking for the first N alphanumeric chars.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
my $firstn = 4;
die "Usage: mask-code [--debug] [--firstn N] code+\n"
	unless GetOptions( "debug"=>\$debug, "firstn=i"=>\$firstn ) && @ARGV>0;


#
# my $masked = mask($code,$firstn);
#	Perform the masking as specified above to $code,
#	returning $masked.  eg mask("1234567.a")="xxxx567.a";
#
sub mask
{
	my( $code,$firstn ) = @_;
	my $found = 0;
	for( my $pos=0; $pos<length($code) && $found<$firstn; $pos++ )
	{
		if( substr($code,$pos,1) =~ /^\w$/ )
		{
			substr($code,$pos,1) = 'x';
			$found++;
		}
	}
	return $code;
}


my @code = @ARGV;
@code = map { mask($_,$firstn) } @code;

say join(',',@code);
