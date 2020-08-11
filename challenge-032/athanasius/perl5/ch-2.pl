#!perl

################################################################################
=comment

Perl Weekly Challenge 032
=========================

Task #2
-------
Contributed by Neil Bowers

ASCII bar chart

Write a function that takes a hashref where the keys are labels and the values
are integer or floating point values. Generate a bar graph of the data and dis-
play it to stdout.

The input could be something like:

  $data = { apple => 3, cherry => 2, banana => 1 };
  generate_bar_graph($data);

And would then generate something like this:

   apple | ############
  cherry | ########
  banana | ####

If you fancy then please try this as well: (a) the function could let you speci-
fy whether the chart should be ordered by (1) the labels, or (2) the values.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use List::Util qw( max );

const my $BAR_CHARACTER   => '#';
const my $BAR_MULTIPLIER  =>  4;
const my $ORDER_BY_LABELS =>  0;
const my $ORDER_BY_VALUES =>  1;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my    $data =
          {
              cherry     => 2,
              apple      => 1.5,
              banana     => 3,
              watermelon => 2,
              mango      => 3.8,
          };

    my    $graph = generate_bar_graph($data, $ORDER_BY_LABELS);
    print $graph, "\n";

          $graph = generate_bar_graph($data, $ORDER_BY_VALUES);
    print $graph;
}

#-------------------------------------------------------------------------------
sub generate_bar_graph
#-------------------------------------------------------------------------------
{
    my ($data, $by_values) = @_;

    my  @keys = keys %$data;

    if ($by_values)     # Order by values
    {
        @keys = sort
                {
                    $data->{$b} <=> $data->{$a}     # Descending
                    ||
                    $a cmp $b                       # Lexicographical

                } @keys;
    }
    else                # Order by labels
    {
        @keys = sort @keys;                         # Lexicographical only
    }

    my $width = max map { length } @keys;
    my $graph = '';

    for my $key (@keys)
    {
        my $bar = $BAR_CHARACTER x ($BAR_MULTIPLIER * $data->{$key});
        $graph .= sprintf "  %*s | %s\n", $width, $key, $bar;
    }

    return $graph;
}

################################################################################
