#!/usr/bin/perl
#
# Task 2: "Magical Matrix
#
# Write a script to display matrix as below with numbers 1 - 9. Please make sure numbers are used once.
# 
# [ a b c ]
# [ d e f ]
# [ g h i ]
# 
# So that it satisfies the following:
# 
# a + b + c = 15
# d + e + f = 15
# g + h + i = 15
# a + d + g = 15
# b + e + h = 15
# c + f + i = 15
# a + e + i = 15
# c + e + g = 15
# "
# 
# My notes: clearly defined.  Constraint problem.
# 

use strict;
use warnings;
use Data::Dumper;
use Function::Parameters;
use feature 'say';
use Getopt::Long;

my $debug = 0;
die "Usage: magic-square [--debug]\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV==0;


#
# thirdrow( $a, $b, $c, $d, $e, $f, %used );
#	Given consistent values $a..$f which satisfy all constraints for the
#	first two rows, and %used, the set of all values $a..$f, try to
#	find values of the third row ($g, $h and $i) which work, printing
#	any solutions we find.  Of course, all of $h, $h and $i are forced
#	by the earlier values..
#
fun thirdrow( $a, $b, $c, $d, $e, $f, %used )
{
	my $g=15-$a-$d;		# g is forced

	# now check $g
	if( $g>=1 && $g<=9 && ! $used{$g} )
	{
		$used{$g} = 1;
		say "$a $b $c\n$d $e $f\n$g ? ?\n" if $debug;

		my $h = 15-$b-$e;	# h is forced

		# now check $h
		if( $h>=1 && $h<=9 && ! $used{$h} )
		{
			$used{$h} = 1;
			say "$a $b $c\n$d $e $f\n$g $h ?\n" if $debug;

			my $i=15-$g-$h;		# $i is forced

			# now check $i
			if( $i>=1 && $i<=9 && ! $used{$i} && $a+$e+$i==15 && $c+$f+$i==15 )
			{
				say "solution:\n$a $b $c\n$d $e $f\n$g $h $i";
			}

			delete $used{$h};
		}
		delete $used{$g};
	}
}


#
# secondrow( $a, $b, $c, %used );
#	Given a consistent first row of a magic square $a, $b and $c,
#	which satisfy first row constraints (i.e. are distinct values in the
#	range 1..9 which sum to 15), and %used (the set of $a, $b and $c),
#	find all possible magic squares by finding all possible values for
#	the second and third rows..  print out all solutions found.
#
fun secondrow( $a, $b, $c, %used )
{
	foreach my $d (1..9)
	{
		next if $used{$d} || $a+$d>14;
		$used{$d} = 1;
		foreach my $e (1..9)
		{
			next if $used{$e} || $a+$e>14 || $b+$e>14 || $d+$e>14;
			$used{$e} = 1;

			my $f = 15-$d-$e;			# f is forced
			if( $f>=1 && $f<=9 && ! $used{$f} )
			{
				$used{$f} = 1;

				thirdrow( $a, $b, $c, $d, $e, $f, %used );

				delete $used{$f};
			}
			delete $used{$e};
		}
		delete $used{$d};
	}
}


#
# allsquares();
#	Try all magic squares, printing out all solutions found.
#
fun allsquares(  )
{
	# first the top row $a, $b and $c:
	foreach my $a (1..9)
	{
		my %used = ($a=>1);
		foreach my $b (1..9)
		{
			next if $used{$b} || $a+$b>14;
			$used{$b} = 1;
			my $c = 15-$a-$b;			 # c is forced
			if( $c>=1 && $c<=9 && ! $used{$c} )
			{
				$used{$c} = 1;
				secondrow( $a, $b, $c, %used );
				delete $used{$c};
			}
			delete $used{$b};
		}
	}
}


allsquares();
