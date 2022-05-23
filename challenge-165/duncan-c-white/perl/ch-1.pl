#!/usr/bin/perl
# 
# TASK 1: Scalable Vector Graphics (SVG)
# 
# Scalable Vector Graphics (SVG) are not made of pixels, but lines,
# ellipses, and curves, that can be scaled to any size without any loss
# of quality. If you have ever tried to resize a small JPG or PNG, you
# know what I mean by 'loss of quality'! What many people do not know
# about SVG files is, they are simply XML files, so they can easily be
# generated programmatically.
# 
# For this task, you may use external library, such as Perl's SVG library,
# maintained in recent years by our very own Mohammad S Anwar. You can
# instead generate the XML yourself; it's actually quite simple. The
# source for the example image for Task #2 might be instructive.
# 
# Your task is to accept a series of points and lines in the following format, one per line, in arbitrary order:
# 
# Point: x,y
# Line: x1,y1,x2,y2
# 
# Example:
# 
# 53,10
# 53,10,23,30
# 23,30
# 
# Then, generate an SVG file plotting all points, and all lines. If done
# correctly, you can view the output .svg file in your browser.
# 
# MY NOTES: ok.  Having read the SVG Wikipedia page, it seems very easy to do this myself (although I hate XML).
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
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
die "Usage: mk-svg [--debug] [inputfile]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my @pt;		# points, each point an [x,y] pair
my @ln;		# lines, each line an [x1,y1,x2,y2] tuple

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
	} elsif( @x == 4 )
	{
		push @ln, \@x;
		updatewh( @x[0,1] );
		updatewh( @x[2,3] );
	} else
	{
		die "Error at line $.: 2 or 4 numbers expected: $_\n";
	}
}

my( $w, $h ) = @wh{qw(W H)};
$w += (10-$w%10);
$h += (10-$h%10);

my $xscale = $w < 200 ? 200/$w : 1;
my $yscale = $h < 200 ? 200/$h : 1;

warn "maxxy rectangle is w $w, h $h, xscale $xscale, yscale $yscale\n" if $debug;

start_svg( $w * $xscale, $h * $yscale );

setcolour( "blue" );
setlinewidth( 1 );
line( $_->[0]*$xscale, $_->[1]*$yscale,
      $_->[2]*$xscale, $_->[3]*$yscale ) foreach @ln;

setcolour( "orange" );
point( $_->[0]*$xscale, $_->[1]*$yscale ) foreach @pt;

end_svg();
