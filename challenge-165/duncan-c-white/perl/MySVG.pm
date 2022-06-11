package MySVG;

use strict;
use warnings;
use feature 'say';
use Function::Parameters;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(
        start_svg
        expand_macros
	setcolour
	setlinewidth
        point
        line
	rect
        end_svg
        );


=pod

=head2 start_svg( $w, $h );

Generate the xml, doctype and svg tags, width $w by height $h

=cut
fun start_svg( $w, $h )
{
	say qq(<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="$w" height="$h" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">);
}


=pod

=head2 end_svg();

Generate the end svg tag at the end of our svg document

=cut
fun end_svg(  )
{
	say qq(</svg>);
}


my $colour = "red";
my $linewidth = 4;


=pod

=head2 setcolour( $colourname );

Set the current colour.

=cut
fun setcolour( $colourname )
{
	$colour = $colourname;
}


=pod

=head2 setlinewidth( $n );

Set the line width.

=cut
fun setlinewidth( $n )
{
	$linewidth = $n;
}



=pod

=head2 point( $x, $y );

Plot a point.

=cut
fun point( $x, $y )
{
	#say qq(   <line x1="$x" y1="$y" x2="$x" y2="$y" stroke="$colour" stroke-width="$linewidth" />);
	say qq(   <circle cx="$x" cy="$y" r="1" fill="$colour" stroke-width="0" />);
}


=pod

=head2 line( $x1, $y1, $x2, $y2 );

Draw a line from (x1,y1) to (x2,y2)

=cut
fun line( $x1, $y1, $x2, $y2 )
{
	say qq(   <line x1="$x1" y1="$y1" x2="$x2" y2="$y2" stroke="$colour" stroke-width="$linewidth" />);
}


=pod

=head2 rect( $x1, $y1, $x2, $y2 );

Draw a rectangle from (x1,y1) to (x2,y2)

=cut
fun rect( $x1, $y1, $x2, $y2 )
{
	my $w = 1+$x2-$x1;
	my $h = 1+$y2-$y1;
	say qq(   <rect x1="$x1" y1="$y1" width="$w" height="$h" fill="white" stroke="$colour" stroke-width="$linewidth" />);
}


1;
