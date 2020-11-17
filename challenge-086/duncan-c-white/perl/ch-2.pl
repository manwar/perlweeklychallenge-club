#!/usr/bin/perl
#
# Task 2: "Sudoku Puzzle
#
# You are given Sudoku puzzle (9x9).
#
# Write a script to complete the puzzle and must respect the following rules:
# a) Each row must have the numbers 1-9 occuring just once.
# b) Each column must have the numbers 1-9 occuring just once.
# c) The numbers 1-9 must occur just once in each of the 9 sub-boxes (3x3) of the grid.
# 
# Example:
# 
# [ _ _ _ 2 6 _ 7 _ 1 ]
# [ 6 8 _ _ 7 _ _ 9 _ ]
# [ 1 9 _ _ _ 4 5 _ _ ]
# [ 8 2 _ 1 _ _ _ 4 _ ]
# [ _ _ 4 6 _ 2 9 _ _ ]
# [ _ 5 _ _ _ 3 _ 2 8 ]
# [ _ _ 9 3 _ _ _ 7 4 ]
# [ _ 4 _ _ 5 _ _ 3 6 ]
# [ 7 _ 3 _ 1 8 _ _ _ ]
# 
# Output:
# 
# [ 4 3 5 2 6 9 7 8 1 ]
# [ 6 8 2 5 7 1 4 9 3 ]
# [ 1 9 7 8 3 4 5 6 2 ]
# [ 8 2 6 1 9 5 3 4 7 ]
# [ 3 7 4 6 8 2 9 1 5 ]
# [ 9 5 1 7 4 3 6 2 8 ]
# [ 5 1 9 3 2 6 8 7 4 ]
# [ 2 4 8 9 5 7 1 3 6 ]
# [ 7 6 3 4 1 8 2 5 9 ]
# 
# As the above puzzle respect the 3 rules including 9-sub-boxes as shown below:
# 
# [ 4 3 5 ] [ 2 6 9 ] [ 7 8 1 ]
# [ 6 8 2 ] [ 5 7 1 ] [ 4 9 3 ]
# [ 1 9 7 ] [ 8 3 4 ] [ 5 6 2 ]
# 
# [ 8 2 6 ] [ 1 9 5 ] [ 3 4 7 ]
# [ 3 7 4 ] [ 6 8 2 ] [ 9 1 5 ]
# [ 9 5 1 ] [ 7 4 3 ] [ 6 2 8 ]
# 
# [ 5 1 9 ] [ 3 2 6 ] [ 8 7 4 ]
# [ 2 4 8 ] [ 9 5 7 ] [ 1 3 6 ]
# [ 7 6 3 ] [ 4 1 8 ] [ 2 5 9 ]
# 
# My notes: excuse me? write a sudoku solver in 2 and a half hours?  no way!
#	fortunately I already had a solver, which did clever deductions after
#	working out the possible sets for each cell.  But for this, I throw
#	away all the clever deductions and wrote a brute force searcher:
#	- read the puzzle
#	- form the possible sets
#	- eliminate known cells from intersecting rows, columns and boxes
#	then solve by:
#	- finding an unknown cell (r,c) with possible values @possval
#	- for each @possval, clone the puzzle, set cell (r,c) to the chosen value and recurse
# 

use strict;
use warnings;
use Data::Dumper;
use feature 'say';

my $size = 9;			# 9x9 puzzles always..  don't try changing this!


#
# my $puzref = readpuz( $fh );
#	read a puzzle from file handle $fh.
#	return a puzzle arrayref
#
sub readpuz ($)
{
	my( $infh ) = @_;

	my @puz = ();
	foreach (1..$size)
	{
		my $line = <$infh>;
		chomp $line;
		die "readpuz: line '$line' not $size chars long\n"
			unless length($line)==$size;
		die "readpuz: invalid line '$line'\n" unless
			$line =~ /^(\d| ){$size}$/o;
		my @x = split( //, $line );
		map {
			$_ = "123456789" if $_ eq " ";
		} @x;
		push( @puz, \@x );
	}
	#die "readpuz: puz = ". Dumper(\@puz);

	return \@puz;
}


#
# showpuz( $verbose, @puz );
#	show the puzzle prettily, verbosely if asked
#
sub showpuz ($@)
{
	my( $verbose, @puz ) = @_;
	if( $verbose )
	{
		my @rowlet = ( "A".."I" );	# row letters
		foreach my $row (0..$size-1)
		{
			my $line1 = my $line2 = " |";
			if( $verbose )
			{
				$line2 = "$rowlet[$row]|";
			}
			foreach my $cell (@{$puz[$row]})
			{
				if( $verbose )
				{
					my $val = length($cell)==1 ? $cell : " ";	# unknown if length()>1
					my $p1 = "    ";
					my $p2 = "     ";
					if( length($cell)>1 )
					{
						my $p9 = substr( $cell."         ", 0, 9 );
						$p9 =~ /^(....)(.*)$/;
						$p1 = $1;
						$p2 = $2;
					}
					$line1 .= " $val $p1 |";
					$line2 .= "  $p2 |";
				} else
				{
					my $val = length($cell)==1 ? $cell : " ";	# unknown if length()>1
					$line1 .= " $val |";
				}
			}
			print "$line1\n";
			next unless $verbose;
			print "$line2\n";
			print " ".("|        " x $size);
			print "|\n";
		}
	} else
	{
		foreach my $row (0..$size-1)
		{
			my $line1 = "";
			foreach my $cell (@{$puz[$row]})
			{
				my $val = length($cell)==1 ? $cell : " ";	# unknown if length()>1
				$line1 .= $val;
			}
			print "$line1\n";
		}
	}
}


#
# my $changed = eliminateoneknown( $row, $col, $val, @puz );
#	cell (row,col) is a known value $val - so modify the rest of the puzzle @puz
#	to reflect the things that we now know: that $val is not possible
#	in all cells in the same row, all cells in the same column
#	and all cells in the same box.
#	Return 1 iff the puzzle changes.
#
sub eliminateoneknown ($$$@)
{
	my( $row, $col, $val, @puz ) = @_;
	die "eliminateoneknown: bad args ($row,$col,$val) - puz($row,$col) != $val\n"
		unless $puz[$row][$col] eq $val;

	my $changed = 0;

	# $val is not possible in col $col
	foreach my $r (0..$size-1)
	{
		next if $r == $row;
		my $cell = $puz[$r][$col];
		next if length($cell)==1;
		if( $cell =~ /$val/ )
		{
			$cell =~ s/$val//;
			$puz[$r][$col] = $cell;
			$changed = 1;
		}
	}
	# $val is not possible in row $row
	foreach my $c (0..$size-1)
	{
		next if $c == $col;
		my $cell = $puz[$row][$c];
		next if length($cell)==1;
		if( $cell =~ /$val/ )
		{
			$cell =~ s/$val//;
			$puz[$row][$c] = $cell;
			$changed = 1;
		}
	}
	# $val is not possible anywhere in the same box as (row,col)
	my $boxr1 = $row - $row%3;
	my $boxr2 = $boxr1 + 2;
	my $boxc1 = $col - $col%3;
	my $boxc2 = $boxc1 + 2;
	foreach my $c ($boxc1..$boxc2)
	{
		foreach my $r ($boxr1..$boxr2)
		{
			next if $r == $row && $c == $col;
			my $cell = $puz[$r][$c];
			next if length($cell)==1;
			if( $cell =~ /$val/ )
			{
				$cell =~ s/$val//;
				$puz[$r][$c] = $cell;
				$changed = 1;
			}
		}
	}
	return $changed;
}


#
# my $changed = eliminate( @puz );
#	locate all known cells, and eliminate each from
#	overlapping rows, columns and boxes.
#	Return 1 iff the puzzle changes.
#
sub eliminate
{
	my( @puz ) = @_;
	my $changed = 0;
	foreach my $row (0..$size-1)
	{
		foreach my $col (0..$size-1)
		{
			my $cell = $puz[$row][$col];
			next unless length($cell)==1;
			$changed ||= eliminateoneknown( $row, $col, $cell, @puz );
		}
	}
	return $changed;
}


#
# my $unknowns = countunknowns( @puz );
#	Count how many unknowns there are in @puz.
#
sub countunknowns
{
	my( @puz ) = @_;
	my $unknowns = 0;
	foreach my $row (0..$size-1)
	{
		foreach my $col (0..$size-1)
		{
			my $cell = $puz[$row][$col];
			$unknowns++ if length($cell)>1;
		}
	}
	return $unknowns;
}


#
# my( $r, c ) = findfirstunknown(@puz);
#	Find the first unknown cell, returning it's row and column no.
#	If there are no unknown cells, return (0,0)
#
sub findfirstunknown
{
	my( @puz ) = @_;
	foreach my $row (0..$size-1)
	{
		foreach my $col (0..$size-1)
		{
			my $cell = $puz[$row][$col];
			return ($row,$col) if length($cell)>1;
		}
	}
	return (0,0);
}


#
# my $maxfreq = maxfreqinbox( $boxrn,$boxcn,@puz);
#	Check the contents of the box ($boxrn:0..2, $boxcn:0..2)
#	to find the maximum frequency of all known elements in there.
#
sub maxfreqinbox
{
	my( $boxrn, $boxcn, @puz ) = @_;

	my $boxr1 = $boxrn*3;
	my $boxr2 = $boxr1 + 2;
	my $boxc1 = $boxcn*3;
	my $boxc2 = $boxc1 + 2;
	my %freq;
	my $maxfreq = 0;
	foreach my $c ($boxc1..$boxc2)
	{
		foreach my $r ($boxr1..$boxr2)
		{
			my $cell = $puz[$r][$c];
			next unless length($cell)==1;
			$freq{$cell}++;
			$maxfreq = $freq{$cell} if $freq{$cell}>$maxfreq;
		}
	}
	return $maxfreq;
}


#
# my $isconsistent = consistent(@puz);
#	Return 1 iff the puzzle @puz is consistent so far.
#	Return 0 if there are any problems:
#	- a cell with 0 possibilities
#	- 2 cells in the same row/column/box with same value
#
sub consistent
{
	my( @puz ) = @_;
	foreach my $row (0..$size-1)
	{
		foreach my $col (0..$size-1)
		{
			my $cell = $puz[$row][$col];
			return 0 if length($cell)==0;	# no possibilities
		}
	}

	foreach my $row (0..$size-1)
	{
		# ok, find frequencies of all known values in this row
		my %freq;
		my $maxfreq=0;
		foreach my $col (0..$size-1)
		{
			my $cell = $puz[$row][$col];
			next unless length($cell)==1;
			$freq{$cell}++;
			$maxfreq = $freq{$cell} if $freq{$cell}>$maxfreq;
		}

		if( $maxfreq>1 )
		{
			say "not consistent due to max freq $maxfreq in row $row";
			return 0;
		}
	}

	foreach my $col (0..$size-1)
	{
		# ok, find frequencies of all known values in this column
		my %freq;
		my $maxfreq=0;
		foreach my $row (0..$size-1)
		{
			my $cell = $puz[$row][$col];
			next unless length($cell)==1;
			$freq{$cell}++;
			$maxfreq = $freq{$cell} if $freq{$cell}>$maxfreq;
		}

		if( $maxfreq>1 )
		{
			say "not consistent due to max freq $maxfreq in column $col";
			return 0;
		}
	}


	foreach my $boxrn (0..2)
	{
		foreach my $boxcn (0..2)
		{
			# count maxfreq of items in box ($boxrn,$boxcn)
			my $maxfreq = maxfreqinbox( $boxrn,$boxcn,@puz);
			if( $maxfreq>1 )
			{
				say "not consistent due to max freq $maxfreq in box $boxrn, $boxcn";
				return 0;
			}
		}
	}

	# ok if we get to the end..
	say "consistent";
	return 1;
}


#
# my @clone = clonepuz( @puz );
#	Clone the entire puzzle.  Return the new identical puzzle.
#
sub clonepuz
{
	my( @puz ) = @_;
	my @result = map { [ @$_ ] } @puz;
	return @result;
}


#
# my( $solved, @solvedpuz ) = solve( $pass, @puz );
#	Brute force solve @puz: locate the first unknown cell.
#	Then, foreach possible value of that cell, clone the puzzle,
#	set that cell to that value, and brute force again.
#	Fail whenever a cell becomes empty;
#	succeed whenever the puzzle has no unknowns.
#
sub solve
{
	my( $pass, @puz ) = @_;

	my( $r, $c ) = findfirstunknown(@puz);
	my $poss = $puz[$r][$c];
	say "solve pass $pass: found unknown cell ($r,$c), possible values $poss";

	my @poss = split(//,$poss);
	foreach my $value (@poss)
	{
		my @clone = clonepuz( @puz );
		say "solve pass $pass: try cell ($r,$c)=$value";
		$clone[$r][$c] = $value;

		# eliminate until no changes..
		while( eliminate( @clone ) )
		{
		}

		say "solve pass $pass: board is";
		showpuz( 1, @clone );

		my $isconsistent = consistent(@clone);
		unless( $isconsistent )
		{
			say "solve pass $pass: not consistent";
			next;
		}

		my $unknowns = countunknowns( @clone );
		print "\nthere are $unknowns unknowns\n";
		return (1, @clone) if $unknowns==0;

		my( $solved, @solvedpuz ) = solve( $pass+1,@clone );
		return (1, @solvedpuz) if $solved;
	}
	say "solve pass $pass: fail";
	return (0);
}


die "Usage: bruteforcesudokusolver inputfile\n" unless @ARGV == 1;

my $puzfile = shift;
open( my $infh, '<', $puzfile ) || die;

STDOUT->autoflush(1);
STDERR->autoflush(1);
STDIN->autoflush(1);

#print "please enter your sudoku board:\n";
my ( $puzref, @hint ) = readpuz($infh);
$infh->close;
my @puz = @$puzref;

print "\n";

print "\ninitially puzzle is:\n\n";
showpuz( 1, @puz );

# eliminate until no changes..
while( eliminate( @puz ) )
{
}

print "\nafter eliminations puzzle is:\n\n";
showpuz( 1, @puz );

my $unknowns = countunknowns( @puz );
print "\nthere are $unknowns unknowns\n";

my( $solved, @solvedpuz ) = solve( 1, @puz );

unless( $solved )
{
	say "No solution found";
} else
{
	print "\nafter brute force solving, puzzle is:\n\n";
	showpuz( 0, @solvedpuz );
}
