#!/usr/bin/perl
# 
# Task 2: "Transpose File
# 
# You are given a text file.
# 
# Write a script to transpose the contents of the given file.
#
# Input File
# 
# name,age,sex
# Mohammad,45,m
# Joe,20,m
# Julie,35,f
# Cristina,10,f
# 
# Output:
# 
# name,Mohammad,Joe,Julie,Cristina
# age,45,20,35,10
# sex,m,m,f,f
# "
# 
# My notes: simple to state.  Basically read into 2-D array and transpose
# array.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Text::CSV;
#use Data::Dumper;


#
# my @t = transpose(@a);
#	Transpose @a into @t.
#
fun transpose( @a )
{
	my $cols = @{$a[0]};
	my @result;
	foreach my $r (0..$#a)
	{
		foreach my $c (0..$cols-1)
		{
			$result[$c][$r] = $a[$r][$c];
		}
	}
	return @result;
}


die "Usage: tranposecsv\n" unless @ARGV==0;

my @a;	# 2-d array

my $csv = Text::CSV->new ( { binary => 1 } )
	     || die "Cannot use CSV: ".Text::CSV->error_diag ();

while( <> )
{
	my $status = $csv->parse($_);
	die "bad line $_\n" unless $status;
	my @f = $csv->fields();
	push @a, \@f;
}

#die Dumper \@a;

my @t = transpose(@a);
foreach my $row (@t)
{
	$csv->print( \*STDOUT, $row);
	print "\n";
}
