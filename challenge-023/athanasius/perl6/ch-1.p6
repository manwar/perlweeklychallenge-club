use v6;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my UInt:D constant $ORDER = 1;

BEGIN say '';

#===============================================================================
sub MAIN(*@series, UInt:D :$order = $ORDER)
#===============================================================================
{
    check-arguments(@series, $order);

    for 1 .. $order
    {
        my UInt $max-index = @series.elems - 1;

        my @new-series;
           @new-series.push(@series[$_] - @series[$_ - 1]) for 1 .. $max-index;

        @series = @new-series;
    }

    "%s order forward difference series:\n(%s)\n".printf:
        ordinal($order), join(', ', @series);

    CATCH
    {
        default 
        {
            $*ERR.say: .message ~ "\n" ~ $*USAGE;
        }
    }
}

#-------------------------------------------------------------------------------
sub check-arguments(@series, UInt:D $order)
#-------------------------------------------------------------------------------
{
    my UInt $elements = @series.elems;

    $elements > 1
        or die "Invalid number of elements ($elements) in the series: must " ~
               "be at least 2";

    $order > 0
        or die "Invalid order ($order): must be an integer > 0";

    $order < $elements
        or die "Invalid order ($order): a series of $elements elements " ~
               "cannot have an order > { $elements - 1 }";
}

#-------------------------------------------------------------------------------
sub ordinal(UInt:D $cardinal)
#-------------------------------------------------------------------------------
{
    my $suffix  = 'th';
    my $digit_0 =  $cardinal % 10;
    my $digit_1 = ($cardinal / 10).floor % 10;

    if ($digit_1 != 1)
    {
        $suffix = $digit_0 == 1 ?? 'st' !!
                  $digit_0 == 2 ?? 'nd' !!
                  $digit_0 == 3 ?? 'rd' !! 'th';
    }

    return $cardinal ~ $suffix;
}

################################################################################
