#!perl

################################################################################
=comment

Perl Weekly Challenge 026
=========================

Task #2
-------
Create a script that prints *mean angles* of the given list of angles in
degrees. Please read [ https://en.wikipedia.org/wiki/Mean_of_circular_quantities
|wiki page] that explains the formula in details with an example.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use utf8;
use Const::Fast;
use Data::Types qw( is_float );
use Getopt::Long;

const my $PI    => 4 * atan2(1, 1);
const my $USAGE =>
    "USAGE:\n  perl $0 [<angles> ...]\n" .
            "  perl $0 -- [<angles> ...] (to include +/- prefixes)\n" .
            "  perl $0 [--filename=<Str>]\n";

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    # Parse the command line

    GetOptions('file=s' => \my $file)
        or  die $USAGE;

    defined $file && scalar @ARGV > 0
        and die "ERROR: Found filename as well as angle(s)\n$USAGE";

    # Read and validate the input data

    my @angles = defined $file ? read_file($file) : @ARGV;

    scalar @angles > 0
        or  die $USAGE;

    for my $angle (@angles)
    {
        is_float($angle)
            or die "ERROR: Invalid angle \"$angle\"\n$USAGE";
    }

    # Calculate and display the circular mean

    printf "The circular mean of the angle%s\n  (%s)\nis %s°\n",
            scalar @angles == 1 ? '' : 's',
            join(', ',  map { "$_°" }  @angles),
            sprintf find_circular_mean(@angles);
}

#-------------------------------------------------------------------------------
sub read_file
#-------------------------------------------------------------------------------
{
    my ($file) = @_;
    my  @angles;

    open my $fh, '<', $file
        or die "Cannot open file \"$file\" for reading, stopped";

    # File format: one angle (in degrees) per line; blank lines are ignored

    while (my $line = <$fh>)
    {
        $line =~ s/ ^ \s+   //x;  # trim leading  whitespace
        $line =~ s/   \s+ $ //x;  # trim trailing whitespace (including newline)

        next if $line eq '';

        push @angles, $line;
    }

    close $fh
        or die "Cannot close file \"$file\", stopped";

    return @angles;
}

#-------------------------------------------------------------------------------
sub find_circular_mean
#-------------------------------------------------------------------------------
{
    # The circular mean (in radians) is given by the formula:
    #
    #     atan2( 1/n ∑ [j=1..n] sin α_j, 1/n ∑ [j=1..n] cos α_j )

    my @angles         = @_;
    my $sum_of_sines   = 0;
    my $sum_of_cosines = 0;

    for my $degrees (@angles)
    {
        my $radians      = $degrees * ($PI / 180);
        $sum_of_sines   += sin $radians;              # build ∑ [j=1..n] sin α_j
        $sum_of_cosines += cos $radians;              # build ∑ [j=1..n] cos α_j
    }

    my $n = scalar @angles;

    return atan2($sum_of_sines / $n, $sum_of_cosines / $n) * (180 / $PI);
}

################################################################################
