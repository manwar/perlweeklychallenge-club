#!perl

###############################################################################
=comment

Perl Weekly Challenge 093
=========================

Task #1
-------
*Max Points*

Submitted by: Mohammad S Anwar

You are given set of co-ordinates @N.

Write a script to count maximum points on a straight line when given co-
ordinates plotted on a 2-d plane.

Example 1:

 |
 |     *
 |   *
 | *
 + _ _ _ _

 Input: (1,1), (2,2), (3,3)
 Output: 3

Example 2:

 |
 |
 | *       *
 |   *
 | *   *
 + _ _ _ _ _

 Input: (1,1), (2,2), (3,1), (1,3), (5,3)
 Output: 3

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use lib            qw( . );
use Line;

const my $VERBOSE => 0;
const my $USAGE   =>
"Usage:
  perl $0 [<coords> ...]

    [<coords> ...]    Cartesian plane co-ordinates such as (1.5,-7) or " .
                                                          "(+3,0.2)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 093, Task #1: Max Points (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N;

    for my $pair (@ARGV)
    {
        $pair =~ m{ ^ \( ( $RE{num}{real} ) \, ( $RE{num}{real} ) \) $ }x
            or die qq[ERROR: Malformed coordinate pair "$pair"\n$USAGE];

        push @N, [ 0 + $1, 0 + $2 ];
    }

    @N = sort_and_remove_duplicates( @N );

    printf "Input: %s\n", join ', ',
                          map { '(' . $_->[0] . ',' . $_->[1] . ')' } @N;

    my $max_line = find_max_line( @N );

    if (defined $max_line)
    {
        printf "Output: %d%s\n",
                $max_line->count_points,
                $VERBOSE ? ', viz. ' . $max_line->show_points : '';
    }
    else
    {
        print  "Output: 0\n";
    }
}

#------------------------------------------------------------------------------
sub find_max_line
#------------------------------------------------------------------------------
{
    my (@N) = @_;
    my  $max_line;

    if (scalar @N >= 2)
    {
        my @lines;

        for my $i (0 .. $#N - 1)
        {
            for my $j ($i + 1 .. $#N)
            {
                my $found    = 0;
                my $new_line = Line->new( $N[$i]->[0], $N[$i]->[1],
                                          $N[$j]->[0], $N[$j]->[1] );

                for my $existing_line (@lines)
                {
                    if ($new_line->collinear( $existing_line ))
                    {
                        $existing_line->add_point( $N[$j] );
                        $found = 1;
                        last;
                    }
                }

                push @lines, $new_line unless $found;
            }
        }

        my $max_count = 0;

        for my $line (@lines)
        {
            if ((my $count = $line->count_points) > $max_count)
            {
                $max_count = $count;
                $max_line  = $line;
            }
        }
    }

    return $max_line;
}

#------------------------------------------------------------------------------
sub sort_and_remove_duplicates
#------------------------------------------------------------------------------
{
    my (@N)     = @_;
    my  @sorted = sort { $a->[0] <=> $b->[0] ||
                         $a->[1] <=> $b->[1] } @N;
    my  @unique;
    my  $last;

    for my $point (@sorted)
    {
        if (defined $last && $point->[0] == $last->[0] &&
                             $point->[1] == $last->[1])
        {
            printf "WARNING: Duplicate point (%s,%s)\n", $point->[0],
                                                         $point->[1];
        }
        else
        {
            push @unique, $point;
        }

        $last = $point;
    }

    return @unique;
}

###############################################################################
