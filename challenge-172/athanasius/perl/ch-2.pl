#!perl

###############################################################################
=comment

Perl Weekly Challenge 172
=========================

TASK #2
-------
*Five-number Summary*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to compute the five-number summary of the given set of integers.

You can find the definition and example in the
[ https://en.wikipedia.org/wiki/Five-number_summary |wikipedia page].

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Median
------
For n data samples arranged in ascending numerical order:
- if n is odd,  then the median is sample number (n+1)/2.
- if n is even, then the median is the average of sample number n/2 and sample
  number (n/2)+1. [2]

Quartiles
---------
"For discrete distributions, there is no universal agreement on selecting the
quartile values." [3] The approach adopted here is as follows:

  "The lower quartile value is the median of the lower half of the data.
   The upper quartile value is the median of the upper half of the data." [3]

This leaves open the question of whether the median should be included in each
of the lower and upper halves. Set the constant $INCLUDE_MEDIAN as desired.

References
----------
[1] "Five-number summary",
                Wikipedia, https://en.wikipedia.org/wiki/Five-number_summary
[2] "Median",   Wikipedia, https://en.wikipedia.org/wiki/Median
[3] "Quartile", Wikipedia, https://en.wikipedia.org/wiki/Quartile

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $INCLUDE_MEDIAN => 0;
const my $USAGE          =>
"Usage:
  perl $0 [<n> ...]

    [<n> ...]    A non-empty array of integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 172, Task #2: Five-number Summary (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @samples = parse_command_line();
    my @ordered = sort { $a <=> $b } @samples;

    my ($lower, $upper) = $INCLUDE_MEDIAN                       ?
                          quartiles_include_median( \@ordered ) :
                          quartiles_exclude_median( \@ordered );
    
    printf "Input: %s\n\n"          .
           "Five-number Summary\n"  .
           "-------------------\n"  .
           "Sample minimum: %d\n"   .
           "Lower quartile: %.2f\n" .
           "Median:         %.1f\n" .
           "Upper quartile: %.2f\n" .
           "Sample maximum: %d\n",
            join( ', ', @samples ),
            $ordered[  0 ],
            $lower,
            median( \@ordered ),
            $upper,
            $ordered[ -1 ];
}

#------------------------------------------------------------------------------
sub median
#------------------------------------------------------------------------------
{
    my ($samples)    = @_;                      # Ordered (numerical ascending)
    my  $sample_size = scalar @$samples;
    my  $median;

    if ($sample_size % 2 == 0)      # Even
    {
        my $mid    = int( $sample_size / 2 ) - 1;
        my $lower  = $samples->[ $mid     ];
        my $higher = $samples->[ $mid + 1 ];

        $median = ($lower + $higher) / 2;
    }
    else                            # Odd
    {
        $median = $samples->[ int( ($sample_size + 1) / 2 ) - 1 ];
    }

    return $median;
}

#------------------------------------------------------------------------------
sub quartiles_exclude_median                              # "Method 1" from [3]
#------------------------------------------------------------------------------
{
    my ($samples)    = @_;                      # Ordered (numerical ascending)
    my  $sample_size = scalar @$samples;
    my ($lower_end, $upper_start);

    if ($sample_size % 2 == 0)      # Even
    {
        my $mid_point =  $sample_size / 2;
        $lower_end    =  $mid_point - 1;
        $upper_start  =  $mid_point;
    }
    else                            # Odd
    {
        my $mid_point = ($sample_size - 1) / 2;
        $lower_end    =  $mid_point - 1;
        $upper_start  =  $mid_point + 1;
    }

    my @lower_range = @$samples[ 0            .. $lower_end ];
    my @upper_range = @$samples[ $upper_start .. $#$samples ];

    return (median( \@lower_range ), median( \@upper_range ));
}

#------------------------------------------------------------------------------
sub quartiles_include_median       # "Method 2" from [3] (aka "Tukey's hinges")
#------------------------------------------------------------------------------
{
    my ($samples)    = @_;                      # Ordered (numerical ascending)
    my  $sample_size = scalar @$samples;
    my ($lower_end, $upper_start);

    if ($sample_size % 2 == 0)      # Even
    {
        my $mid_point =  $sample_size / 2;
        $lower_end    =  $mid_point - 1;
        $upper_start  =  $mid_point;
    }
    else                            # Odd
    {
        my $mid_point = ($sample_size - 1) / 2;
        $lower_end    =  $mid_point;
        $upper_start  =  $mid_point;
    }

    my @lower_range = @$samples[ 0            .. $lower_end ];
    my @upper_range = @$samples[ $upper_start .. $#$samples ];

    return (median( \@lower_range ), median( \@upper_range ));
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0
            or error( 'No command line arguments found' );

    for my $n (@ARGV)
    {
        $n =~ / ^ $RE{num}{int} $ /x
            or error( qq[Argument "$n" is not a valid integer] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
