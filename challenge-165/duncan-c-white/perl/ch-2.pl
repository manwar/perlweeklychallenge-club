#!/usr/bin/perl
# 
# Task 2: Line of Best Fit
# 
# When you have a scatter plot of points, a line of best fit is the line
# that best describes the relationship between the points, and is very
# useful in statistics. Otherwise known as linear regression, here is an
# example of what such a line might look like:
# 
# [image showing red best fit line on graph of black data points]
# 
# The method most often used is known as the least squares method, as
# it is straightforward and efficient, but you may use any method that
# generates the correct result.
# 
# Calculate the line of best fit for the following 48 points:
# 
# 333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
# 341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
# 284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
# 128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
# 215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
# 275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
# 
# Using your rudimentary graphing engine from Task #1, graph all points, as well as the line of best fit.
# 
# MY NOTES: seems pretty simple, https://www.mathsisfun.com/data/least-squares-regression.html has a good
# explanation of the method.  I've put the above data, one point per line, in "bestfitdata" in the
# top-level directory.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

use lib qw(.);
use MySVG;


my $debug=0;
die "Usage: best-fit-points [--debug] [inputfile]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my @pt;		# points, each point an [x,y] pair

		# %wh will be the width and height of our data
my %wh = ( W => -1, H => -1 );

=pod

=head2 updatewh( $x, $y );

Update %wh rectangle to include $x and $y.

=cut
fun updatewh( $x, $y )
{
	die "x is negative: $x\n" if $x<0;
	die "y is negative: $y\n" if $y<0;
	$wh{W} = $x if $x > $wh{W};
	$wh{H} = $y if $y > $wh{H};
}


while( <> )
{
	chomp;
	s/\s+//g;
	my @x = split(/,/);
	if( @x==2 )
	{
		push @pt, \@x;
		updatewh( @x );
	} else
	{
		die "Error at line $.: x,y numbers expected: $_\n";
	}
}

my( $w, $h ) = @wh{qw(W H)};
$w += (10-$w%10);
$h += (10-$h%10);

my $xscale = $w < 200 ? 200/$w : 1;
my $yscale = $h < 200 ? 200/$h : 1;

warn "debug: maxxy rectangle is w $w, h $h, xscale $xscale, yscale $yscale\n" if $debug;

=pod

=head2 my( $m, $c ) = bestfit( @data );

Calculate y=mx+c, the best fit line of the data (each data point an [x,y] pair)

=cut
fun bestfit( @data )
{
	my $sumx = 0;
	my $sumy = 0;
	my $sumxy = 0;
	my $sumx2 = 0;
	foreach my $pt (@data)
	{
		my( $x, $y ) = @$pt;
		$sumx += $x;
		$sumy += $y;
		$sumxy += $x * $y;
		$sumx2 += $x * $x;
	}
	my $n = @data;
	warn "bestfit: n=$n, sumx=$sumx, sumy=$sumy, sumxy=$sumxy, sumx^2=$sumx2\n" if $debug;

	my $m = ($n * $sumxy - $sumx * $sumy) / ($n * $sumx2 - $sumx * $sumx);
	my $c = ($sumy - $m * $sumx) / $n;

	warn "bestfit: m=$m, c=$c\n" if $debug;
	return( $m, $c );
}


my( $m, $c ) = bestfit( @pt );
my $y1 = $m + $c;			# for x==1
my $y2 = $m * ($w-1) + $c;		# for x==w-1


start_svg( $w * $xscale, $h * $yscale );

setcolour( "black" );
setlinewidth( 1 );
rect( 0, 0, $w-1, $h-1 );

setcolour( "blue" );
setlinewidth( 1 );
line( 1, $y1*$yscale, ($w-1)*$xscale, $y2*$yscale );

setcolour( "orange" );
point( $_->[0]*$xscale, $_->[1]*$yscale ) foreach @pt;

end_svg();
