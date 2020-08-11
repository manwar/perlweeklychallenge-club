#!/usr/bin/perl
#
# Challenge 2: "Write a script to display Digital Clock. Feel free to be
# as creative as you can when displaying digits. We expect bare minimum
# something like '14:10:11'"
# 
# My notes: Sounds like a job for Tk:-)  in this version, after earlier
# building a simple coloured-label clock, I now build a 7-segment LED based
# clock, which handles window resizing properly.  There's something slightly
# strange about the "font" of the LED segments, with the verticals being
# surprisingly thin, actually that's a bug I've run out of time to track
# down, but it's quite appealing somehow:-)
#

use v5.10;	# for "say"
use strict;
use warnings;
use Tk;
use Function::Parameters;
use Data::Dumper;

my $width  = 1000;
my $height = 400;
my $mw;
my $eg = 50;		# edge gap (above, below, to left, and right)
my $g  = 30;		# internal gap (between things)
my $dotw = 20;		# dot width
my $linew = 12;		# width of segment lines
my $digitw;		# 7-segment led digit width, recalculated when we resize
my $hiy;		# high coord of led digits, recalculated when we resize
my $midy;		# middle coord of led digits, recalculated when we resize
my $loy;		# low coord of led digits, recalculated when we resize

die "Usage: ch-2.pl\n" if @ARGV>0;
$mw = MainWindow->new();
$mw->minsize( 200, 50 );
my $canvas = $mw->Canvas(
	-width => $width, -height => $height,
	-background => 'black',
	)->pack(-expand => 1, -fill => 'both');
layout( $width, $height );
$mw->after( 1000, \&setupbindings );

#
# setupbindings();
#	Set up the bindings, not sure why but unless I
#	delay this, the configure event triggers itself
#	with gradually smaller WxH and the clock shrinks
#	to it's minimum size...  gross hack time:-)
#
sub setupbindings
{
	$mw->bind('<q>' => \&exit);
	$mw->bind( "<Configure>" => \&handleresize );
}


#
# handleresize( $widget );
#	Handle a configure (resize or something else) event on $widget.
#	Figure out the new width and height, update globals width and height
#	and change the font size for the label to fit.
#
fun handleresize( $widget )
{
	my $e = $widget->XEvent;
	if( $width != $e->w || $height != $e->h )
	{
		$width  = $e->w;
		$height = $e->h;
		#say "w=$width, h=$height";

		# change layout using $width
		layout( $width, $height );
	}
}


#
# layout( $width, $height );
#	Ok, the dimensions of the mainwindow (and canvas) have changed,
#	now work out how the layout of the LEDs changes in response.
#
fun layout( $width, $height )
{
	$digitw = ( $width - 2 * $eg - 7 * $g - 2 * $dotw ) / 6;
	$hiy    = $eg;
	$midy   = $height/2;
	$loy    = $height - $eg;

	# blank canvas
	$canvas->delete('all');

	# now draw everything grey
	drawdigit( 0, 0 );
	drawdigit( 1, 0 );
	drawcolon( 0 );
	drawdigit( 2, 0 );
	drawdigit( 3, 0 );
	drawdigit( 4, 0);
	drawdigit( 5, 0 );
	drawcolon( 1 );
}


#
# drawdigit( $digitno, $bitset );
#	Draw a 7-led LED, all grey except those elements in the $bitset which
#	are on (which are shown in red), digitno is 0 for leftmost (h1).. 5 for
#	rightmost (s2)
#
fun drawdigit( $digitno, $bitset )
{
	my $lx = $eg + ($digitno*($digitw+$g));
	$lx += $g + $dotw if $digitno>1;
	$lx += $g + $dotw if $digitno>3;

	my $rx = $lx+$digitw-1;

	my $oncol = 'red';
	my $offcol = 'black';

	# line 0: across the top
	my $col = ($bitset&1) ? $oncol : $offcol;
	$canvas->createRectangle( $lx+$linew, $hiy, $rx-$linew, $hiy+$linew,
		-fill=>$col, -outline=>$col );

	# line 1: left hand side, upper
	$col = ($bitset&2) ? $oncol : $offcol;
	$canvas->createRectangle( $lx+$linew, $hiy, $lx+$linew, $midy+$linew,
		-fill=>$col, -outline=>$col );

	# line 2: right hand side, upper
	$col = ($bitset&4) ? $oncol : $offcol;
	$canvas->createRectangle( $rx-$linew, $hiy, $rx-$linew, $midy+$linew,
		-fill=>$col, -outline=>$col );

	# line 3: across the middle
	$col = ($bitset&8) ? $oncol : $offcol;
	$canvas->createRectangle( $lx+$linew, $midy, $rx-$linew, $midy+$linew,
		-fill=>$col, -outline=>$col );

	# line 4: left hand side, lower
	$col = ($bitset&16) ? $oncol : $offcol;
	$canvas->createRectangle( $lx+$linew, $midy, $lx+$linew, $loy+$linew,
		-fill=>$col, -outline=>$col );

	# line 5: right hand side, lower
	$col = ($bitset&32) ? $oncol : $offcol;
	$canvas->createRectangle( $rx-$linew, $midy, $rx-$linew, $loy+$linew,
		-fill=>$col, -outline=>$col );

	# line 6: across the bottom
	$col = ($bitset&64) ? $oncol : $offcol;
	$canvas->createRectangle( $lx+$linew, $loy, $rx-$linew, $loy+$linew,
		-fill=>$col, -outline=>$col );
}


#
# drawcolon( $lr );
#	Draw one colon (either the one between hours/mins if lr==0,
#	or the one between mins/seconds if lr==1
#
fun drawcolon( $lr )
{
	my $lx = $eg + 2 * $digitw + 2 * $g + $dotw/2;
	$lx += 2 * $digitw + 3 * $g + $dotw if $lr==1;

	$canvas->createOval( $lx-$dotw/2, $midy-3*$dotw,
			     $lx+$dotw/2, $midy-2*$dotw,
			     -fill=>'red', -outline=>'red' );
	$canvas->createOval( $lx-$dotw/2, $midy+2*$dotw,
			     $lx+$dotw/2, $midy+3*$dotw,
			     -fill=>'red', -outline=>'red' );
}


# the 7-led sets representing each digit
my @set =
(
	0b1110111,
	0b0100100,
	0b1011101,
	0b1101101,
	0b0101110,
	0b1101011,
	0b1111011,
	0b0100101,
	0b1111111,
	0b0101111,
);


#
# showleds( $h1, $h2, $m1, $m2, $s1, $s2 );
#	Show the LEDs for each digit
#
fun showleds( $h1, $h2, $m1, $m2, $s1, $s2 )
{
	drawdigit( 0, $set[$h1] );
	drawdigit( 1, $set[$h2] );
	drawdigit( 2, $set[$m1] );
	drawdigit( 3, $set[$m2] );
	drawdigit( 4, $set[$s1] );
	drawdigit( 5, $set[$s2] );
}


#
# tick();
#	Update the counter every 1000 milliseconds (second)
sub tick
{
	my( $sec, $min, $hour ) = localtime(time());
	my $h1 = int( $hour / 10 );
	my $h2 = $hour % 10;
	my $m1 = int( $min / 10 );
	my $m2 = $min % 10;
	my $s1 = int( $sec / 10 );
	my $s2 = $sec % 10;
	showleds( $h1, $h2, $m1, $m2, $s1, $s2 );
	$mw->after(1000, \&tick);
}

tick();

MainLoop;
