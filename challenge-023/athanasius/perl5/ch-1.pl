#!perl

################################################################################
=comment

Perl Weekly Challenge 023
=========================

Task #1
-------
Create a script that prints nth order forward difference series. You should be a
able to pass the list of numbers and order number as command line parameters.
Let me show you with an example.

  Suppose we have list (X) of numbers: 5, 9, 2, 8, 1, 6 and we would like to
  create 1st order forward difference series (Y). So using the formula Y(i) =
  X(i+1) - X(i), we get the following numbers: (9-5), (2-9), (8-2), (1-8),
  (6-1). In short, the final series would be: 4, -7, 6, -7, 5. If you noticed,
  it has one less number than the original series. Similary you can carry on 2nd
  order forward difference series like: (-7-4), (6+7), (-7-6), (5+7) => -11, 13,
  -13, 12.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common;

const my $DEBUG => 0;
const my $ORDER => 1;
const my $USAGE => "USAGE: perl $0 [--order=<UInt> --] <Num> <Num>+\n";

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my ($series, $order) = parse_command_line();
    my  $series_string   = '(' . join(', ', @$series) . ')';

    if ($DEBUG)
    {
        printf "%*d: %s\n", length $order, 0, $series_string;
    }
    else
    {
        printf "Original series:\n%s\n",      $series_string;
    }

    for my $o (1 .. $order)
    {
        my   @new_series;
        push @new_series, $series->[$_] - $series->[$_ - 1] for 1 .. $#$series;

        printf( "%*d: (%s)\n", length($order), $o, join(', ', @new_series) )
            if $DEBUG;

        $series = \@new_series;
    }

    printf "\n%s order forward difference series:\n(%s)\n", ordinal($order),
            join(', ', @$series);
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $order = $ORDER;

    GetOptions
    (
        'order=i' => \$order,

    ) or die "Error in command line arguments\n$USAGE";

    $order > 0
        or die "Invalid order ($order): must be an integer > 0\n$USAGE";

    my @series    = @ARGV;
    my $elements  = scalar @series;
    my $max_order = $elements - 1;

    $elements > 1
        or die "Invalid number of elements ($elements) in the series: must " .
               "be at least 2\n$USAGE";

    $order < $elements
        or die "Invalid order ($order): a series of $elements elements " .
               "cannot have an order > $max_order\n$USAGE";

    for my $element (@series)
    {
        $element =~ /$RE{num}{real}/
            or die "Invalid series entry: $element\n$USAGE";
    }

    return (\@series, $order);
}

#-------------------------------------------------------------------------------
sub ordinal
#-------------------------------------------------------------------------------
{
    my ($cardinal) = @_;
    my  $suffix    = 'th';
    my  $digit_0   = $cardinal % 10;
    my  $digit_1   = int($cardinal / 10) % 10;

    if ($digit_1 != 1)
    {
        $suffix = $digit_0 == 1 ? 'st' :
                  $digit_0 == 2 ? 'nd' :
                  $digit_0 == 3 ? 'rd' : 'th';
    }

    return $cardinal . $suffix;
}

################################################################################
