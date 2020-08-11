#!/usr/bin/perl
#
# Task 1: "Sort Email Addresses
#
# Write a script that takes a list of email addresses (one per line)
# and sorts them first by the domain part of the email address, and then
# by the part to the left of the @ (known as the mailbox).
# 
# Note that the domain is case-insensitive, while the mailbox part is case
# sensitive. (Some email providers choose to ignore case, but that's
# another matter entirely.)
# 
# If your script is invoked with arguments, it should treat them as file
# names and read them in order, otherwise your script should read email
# addresses from standard input.
# 
# Bonus
# 
# Add a -u option which only includes unique email addresses in the output,
# just like sort -u.
# 
# Example
# 
# If given the following list:
# 
# name@example.org
# rjt@cpan.org
# Name@example.org
# rjt@CPAN.org
# user@alpha.example.org
# 
# Your script (without -u) would return:
# 
# user@alpha.example.org
# rjt@cpan.org
# rjt@CPAN.org
# Name@example.org
# name@example.org
# 
# With -u, the script would return:
# 
# user@alpha.example.org
# rjt@CPAN.org
# Name@example.org
# name@example.org
# "
# 
# My notes: cool question. Will have a go!  I also added '-i' meaning:
# treat the mailname part as case-insensitive as well.  Running this
# script on the above input with -i and -u outputs only:
# 
# user@alpha.example.org
# rjt@CPAN.org
# name@example.org
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;

my $unique = 0;
my $caseinsensitive = 0;
my $result = GetOptions( "u" => \$unique, "i" => \$caseinsensitive );

die "Usage: sort-email-addresses [-u] [-i] (addresses on input)\n"
	unless $result;

my @addr;
while( <> )
{
	chomp;
	s/\s+//g;
	die "bad input $_\n" unless /@/;
	push @addr, $_;
}

sub compare
{
	my( $aname, $adom ) = split( /@/, $a, 2 );
	my( $bname, $bdom ) = split( /@/, $b, 2 );

	# compare domains first, case insensitively
	$adom = lc($adom);
	$bdom = lc($bdom);
	return $adom cmp $bdom if $adom ne $bdom;

	# now compare names, case insensitively if $caseinsensitive
	if( $caseinsensitive )
	{
		$aname = lc($aname);
		$bname = lc($bname);
	}
	return $aname cmp $bname;
}

#
# my $out = sanitize( $in );
#	Sanitize the email address $in, giving $out.
#	Sanitizing means:
#	- lowercasing every domain, because domains are case insensitive
#	- lowercasing every name IF $caseinsensitive
#
fun sanitize( $in )
{
	my( $name, $dom ) = split( /@/, $in, 2 );
	$dom = lc($dom);
	$name = lc($name) if $caseinsensitive;
	return $name.'@'.$dom;
}


my %seen;
@addr = grep { ! $seen{sanitize($_)}++ } @addr if $unique;
@addr = sort compare @addr;

say for @addr;
