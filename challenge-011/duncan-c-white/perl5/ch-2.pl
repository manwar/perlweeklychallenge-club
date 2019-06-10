#!/usr/bin/perl

# Challenge 2: "Write a script to create an Indentity Matrix for the given
# size. For example, if the size is 4, then create Identity Matrix 4x4."
# 
# My notes:
# 
# Surely that's incredibly straight forward.  The identity matrix has 1s on the
# leading diagonal and 0s everywhere else.  But should we create it in memory
# as a 2-D array and print that out, or just print out the identity matrix?
# Let's choose the latter as it's simpler and more direct, even though the
# former approach would be more useful in real life, as presumably this is
# going to be one operation in a Matrix class/module [really, these questions
# need to be BETTER SPECIFIED to clarify this sort of thing]

die "Usage: ch-2.pl N\n" unless @ARGV == 1;

my $n = shift;

die "ch-2.pl: n ($n) must be > 0\n" unless $n>0;

for( $row=0; $row<$n; $row++ )
{
	my $line ='';
	for( $col=0; $col<$n; $col++ )
	{
		my $ch = ($row==$col)?'1':'0';
		$line .= $ch;
	}
	print "$line\n";
}
