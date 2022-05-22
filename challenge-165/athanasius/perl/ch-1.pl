#!perl

###############################################################################
=comment

Perl Weekly Challenge 165
=========================

TASK #1
-------
*Scalable Vector Graphics (SVG)*

Submitted by: Ryan J Thompson

Scalable Vector Graphics (SVG) are not made of pixels, but lines, ellipses, and
curves, that can be scaled to any size without any loss of quality. If you have
ever tried to resize a small JPG or PNG, you know what I mean by "loss of
quality"! What many people do not know about SVG files is, they are simply XML
files, so they can easily be generated programmatically.

For this task, you may use external library, such as Perl's [ https://metacpan.
org/pod/SVG |SVG] library, maintained in recent years by our very own Mohammad
S Anwar. You can instead generate the XML yourself; it's actually quite simple.
The source for the example image for Task #2 might be instructive.

Your task is to accept a series of points and lines in the following format,
one per line, in arbitrary order:

Point: x,y

Line: x1,y1,x2,y2

Example:

  53,10
  53,10,23,30
  23,30

  Then, generate an SVG file plotting all points, and all lines. If done
  correctly, you can view the output `.svg` file in your browser.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Architecture
------------
This file (ch_1.pm) is designed as a modulino:
 - When invoked from the command line, it acts as a standalone script, process-
   ing input from the file supplied on the command line. Line and point data in
   the input file are converted to SVG format, which is then written to a file
   having the same name as the input file but with an '.svg' extension.
 - When use'd or require'd by another script, its encode_svg() subroutine may
   be called with a hash containing data for lines and points to be displayed
   in SVG format, together with the name of the desired output file.

Graph Orientation
-----------------
For SVG, "the initial coordinate system has the origin at the top/left with the
x-axis pointing to the right and the y-axis pointing down." [1] This produces a
graph which is a mirror image of the expected graph, reflected through the x
axis. To correct the appearance of the graph, I have provided the constant
$INVERT_Y which, when set to a true value (the default), triggers the following
transformation:
 - A new baseline is calculated from the maximum y-coordinate among the input
   lines and points.
 - Each y-coordinate is re-mapped so that its distance below the previous base-
   line is now its distance above the new baseline.

SVG Display
-----------
The whole graph is translated down and to the right to make viewing easier. The
translation is governed by the constants $X_OFFSET and $Y_OFFSET. Line and
point sizes and colours are also governed by constants.

SVG images have been viewed in the Google Chrome and Mozilla Firefox browsers.
High magnification (300%+) improves the viewing experience.

Reference
---------
[1] https://www.w3.org/TR/SVG11/coords.html#TransformAttribute

=cut
#==============================================================================

package ch_1;

use strict;
use warnings;
use Const::Fast;
use File::Basename;
use List::Util qw( max );
use SVG;

const my $INVERT_Y     =>  1;
const my $LINE_COLOUR  => 'red';
const my $LINE_WIDTH   => '1';
const my $POINT_COLOUR => 'black';
const my $POINT_RADIUS => '1';
const my $X_OFFSET     => 20;
const my $Y_OFFSET     => 20;
const my $USAGE        =>
"Usage:
  perl $0 <file>

    <file>    Input file [path &] name\n";

main() unless caller;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
}

#==============================================================================
sub main
#==============================================================================
{
    print "\nChallenge 165, Task #1: Scalable Vector Graphics (SVG) (Perl)" .
          "\n\n";

    my  $filepath = _parse_command_line();
    my  $elements = _read_file( $filepath );

    my ($name, $dirs, $suffix) = fileparse( $filepath, qr{ \. [^.]* $ }x );

    $name .= '.new' if $suffix eq '.svg';

    my $outfile = $dirs . $name . '.svg';

    encode_svg( $elements, $outfile );

    print qq[SVG encoded to file "$outfile"\n];
}

#==============================================================================
sub encode_svg
#==============================================================================
{
    my ($elements, $outfile) = @_;
    my  $svg   = SVG->new;
    my  $max_y = $INVERT_Y ? _find_max_y( $elements ) : undef;

    _add_lines ( $svg, $elements->{ lines  }, $max_y );
    _add_points( $svg, $elements->{ points }, $max_y );
    _write_file( $svg, $outfile );
}

#------------------------------------------------------------------------------
sub _find_max_y
#------------------------------------------------------------------------------
{
    my ($elements)    = @_;
    my  $lines        = $elements->{ lines  };
    my  $points       = $elements->{ points };
    my  $max_y_lines  = int( max map {  @$_[ 1, 3 ] } @$lines  );
    my  $max_y_points = int( max map { $_->[ 1    ] } @$points );

    return max( $max_y_lines, $max_y_points ) + 1;
}

#------------------------------------------------------------------------------
sub _add_lines
#------------------------------------------------------------------------------
{
    my ($svg, $lines, $max_y) = @_;

    my $group_of_lines = $svg->group
    (
        id    => 'lines',
        style =>
        {
             stroke        => $LINE_COLOUR,
            'stroke-width' => $LINE_WIDTH,
        },
        transform => "translate($X_OFFSET, $Y_OFFSET)",
    );

    for my $coords (@$lines)
    {
        my $x1 = $coords->[ 0 ];
        my $y1 = $coords->[ 1 ];
        my $x2 = $coords->[ 2 ];
        my $y2 = $coords->[ 3 ];

        if ($INVERT_Y)
        {
            $y1 = $max_y - $y1;
            $y2 = $max_y - $y2;
        }

        $group_of_lines->line( x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2 );
    }
}

#------------------------------------------------------------------------------
sub _add_points
#------------------------------------------------------------------------------
{
    my ($svg, $points, $max_y) = @_;

    my $group_of_points = $svg->group
    (
        id    => 'points',
        style =>
        {
            fill => $POINT_COLOUR,
        },
        transform => "translate($X_OFFSET, $Y_OFFSET)",
    );

    for my $coords (@$points)
    {
        my $cx = $coords->[ 0 ];
        my $cy = $coords->[ 1 ];
           $cy = $max_y - $cy if $INVERT_Y;

        $group_of_points->circle( cx => $cx, cy => $cy, r => $POINT_RADIUS );
    }
}

#------------------------------------------------------------------------------
sub _read_file
#------------------------------------------------------------------------------
{
    my ($file) = @_;
    my  %elements;

    open my $fh, '<', $file
        or die qq[Cannot open file "$file" for reading, stopped];

    while (my $line = <$fh>)
    {
        chomp $line;

        next unless $line =~ / \S /x;                        # Skip empty lines

        my @items = split / \s* \, \s* /x, $line;

        if    (scalar @items == 2)
        {
            push @{ $elements{ points } }, [ @items ];
        }
        elsif (scalar @items == 4)
        {
            push @{ $elements{ lines  } }, [ @items ]; 
        }
        else
        {
            warn qq[WARNING: Ignoring unrecognized SVG element "$line"\n];
        }
    }

    close $fh
        or die qq[Cannot close file "$file", stopped];

    return \%elements;
}

#------------------------------------------------------------------------------
sub _write_file
#------------------------------------------------------------------------------
{
    my ($svg, $file) = @_;

    open my $fh, '>', $file
        or die qq[Cannot open file "$file" for writing, stopped];

    print $fh $svg->xmlify;

    close $fh
        or die qq[Cannot close file "$file", stopped];
}

#------------------------------------------------------------------------------
sub _parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1
        or _error( "Expected 1 command line argument, found $args\n$USAGE" );

    my $file = $ARGV[ 0 ];
    -r $file
        or _error( qq[File "$file" is not readable] );

    return $file;
}

#------------------------------------------------------------------------------
sub _error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
1;
###############################################################################
