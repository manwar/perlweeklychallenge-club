#!perl

###############################################################################
=comment

Perl Weekly Challenge 165
=========================

TASK #2
-------
*Line of Best Fit*

Submitted by: Ryan J Thompson

When you have a scatter plot of points, a line of best fit is the line that
best describes the relationship between the points, and is very useful in
statistics. Otherwise known as linear regression, here is an example of what
such a line might look like:

    < image >

The method most often used is known as the [ https://www.mathsisfun.com/data/
least-squares-regression.html |least squares method], as it is straightforward
and efficient, but you may use any method that generates the correct result.

Calculate the line of best fit for the following 48 points:

333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89

Using your rudimentary graphing engine from Task #1, graph all points, as well
as the line of best fit.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Architecture
------------
Calls ch_1::encode_svg() from the modulino file "ch_1.pm", which implements a
solution to Task 1.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util qw( max min );
use lib        qw( . );
use ch_1;

const my $OUTFILE => 'ch_2.svg';
const my $USAGE   => "Usage:\n  perl $0\n";
const my @POINTS  =>
(
    [333, 129], [ 39, 189], [140, 156], [292, 134], [393,  52], [160, 166],
    [362, 122], [ 13, 193], [341, 104], [320, 113], [109, 177], [203, 152],
    [343, 100], [225, 110], [ 23, 186], [282, 102], [284,  98], [205, 133],
    [297, 114], [292, 126], [339, 112], [327,  79], [253, 136], [ 61, 169],
    [128, 176], [346,  72], [316, 103], [124, 162], [ 65, 181], [159, 137],
    [212, 116], [337,  86], [215, 136], [153, 137], [390, 104], [100, 180],
    [ 76, 188], [ 77, 181], [ 69, 195], [ 92, 186], [275,  96], [250, 147],
    [ 34, 174], [213, 134], [186, 129], [189, 154], [361,  82], [363,  89],
);

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 165, Task #2: Line of Best Fit (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0
            or die "Expected 0 command line arguments, found $args\n$USAGE";

    my $sum_x    = sum( map { $_->[ 0 ]             } @POINTS );
    my $sum_y    = sum( map { $_->[ 1 ]             } @POINTS );
    my $sum_x_sq = sum( map { $_->[ 0 ] * $_->[ 0 ] } @POINTS );
    my $sum_x_y  = sum( map { $_->[ 0 ] * $_->[ 1 ] } @POINTS );
    my $N        = scalar @POINTS;
    my $m        = (($N * $sum_x_y ) - ($sum_x * $sum_y)) /
                   (($N * $sum_x_sq) - ($sum_x * $sum_x));
    my $B        = ($sum_y - ($m * $sum_x)) / $N;
    my %elements;

    push @{ $elements{ points } }, [ @$_ ] for @POINTS;

    my $x1 = (min map { $_->[ 0 ] } @POINTS) - 1;   # min x
    my $y1 = ($m * $x1) + $B;
    my $x2 = (max map { $_->[ 0 ] } @POINTS) + 1;   # max x
    my $y2 = ($m * $x2) + $B;

    push @{ $elements{ lines  } }, [ $x1, $y1, $x2, $y2 ]; 

    ch_1::encode_svg( \%elements, $OUTFILE );

    print qq[SVG encoded to file "$OUTFILE"\n];
}

#------------------------------------------------------------------------------
sub sum
#------------------------------------------------------------------------------
{
    my @data = @_;
    my $sum  = 0;
       $sum += $_ for @data;

    return $sum;
}

###############################################################################
