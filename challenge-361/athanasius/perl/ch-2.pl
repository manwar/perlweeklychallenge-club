#!perl

################################################################################
=comment

Perl Weekly Challenge 361
=========================

TASK #2
-------
*Find Celebrity*

Submitted by: Mohammad Sajid Anwar

You are given a binary matrix (m x n).

Write a script to find the celebrity, return -1 when none found.

    A celebrity is someone, everyone knows and knows nobody.

Example 1

  Input: @party = (
              [0, 0, 0, 0, 1, 0],  # 0 knows 4
              [0, 0, 0, 0, 1, 0],  # 1 knows 4
              [0, 0, 0, 0, 1, 0],  # 2 knows 4
              [0, 0, 0, 0, 1, 0],  # 3 knows 4
              [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
              [0, 0, 0, 0, 1, 0],  # 5 knows 4
         );
  Output: 4

Example 2

  Input: @party = (
              [0, 1, 0, 0],  # 0 knows 1
              [0, 0, 1, 0],  # 1 knows 2
              [0, 0, 0, 1],  # 2 knows 3
              [1, 0, 0, 0]   # 3 knows 0
         );
  Output: -1

Example 3

  Input: @party = (
              [0, 0, 0, 0, 0],  # 0 knows NOBODY
              [1, 0, 0, 0, 0],  # 1 knows 0
              [1, 0, 0, 0, 0],  # 2 knows 0
              [1, 0, 0, 0, 0],  # 3 knows 0
              [1, 0, 0, 0, 0]   # 4 knows 0
         );
  Output: 0

Example 4

  Input: @party = (
              [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
              [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
              [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
              [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
              [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
              [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
         );
  Output: 3

Example 5

  Input: @party = (
              [0, 1, 1, 0],  # 0 knows 1 and 2
              [1, 0, 1, 0],  # 1 knows 0 and 2
              [0, 0, 0, 0],  # 2 knows NOBODY
              [0, 0, 0, 0]   # 3 knows NOBODY
         );
  Output: -1

Example 6

  Input: @party = (
              [0, 0, 1, 1],  # 0 knows 2 and 3
              [1, 0, 0, 0],  # 1 knows 0
              [1, 1, 0, 1],  # 2 knows 0, 1 and 3
              [1, 1, 0, 0]   # 3 knows 0 and 1
         );
  Output: -1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The matrix must in fact be m x m, i.e., square, as shown in all the Examples.
2. It is irrelevant whether or not a celebrity "knows himself."

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of bitstrings is entered on the command-line. The bitstrings
   represent the rows of a non-empty, square, binary matrix.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Dios;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<party> ...]
  perl $0

    [<party> ...]    A list of bitstrings: the rows of a square binary matrix
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 361, Task #2: Find Celebrity (Perl)\n\n";
}

#===============================================================================
class Matrix
#===============================================================================
{
    has Array[Int] @!rows;

    #---------------------------------------------------------------------------
    method find_celebrity( --> Int )
    #---------------------------------------------------------------------------
    {
        my $celebrity = -1;
        my @know_noone;

        for my $row (0 .. $#rows)
        {
            my $sum = 0;

            for my $col (0 .. $#{ $rows[$row] })
            {
                next if $col == $row;

                $sum += $rows[$row][$col];
            }

            push @know_noone, $row if $sum == 0;
        }

        if (scalar @know_noone == 1)
        {
            my $candidate = $know_noone[0];
            my $known     = 1;

            for my $row (0 .. $#rows)
            {
                next if $row == $candidate;

                if ($rows[$row][$candidate] == 0)
                {
                    $known = 0;
                    last;
                }
            }

            $celebrity = $candidate if $known;
        }

        return $celebrity;
    }

    #---------------------------------------------------------------------------
    method format( Int $indent --> Str )
    #---------------------------------------------------------------------------
    {
        my $tab     = ' ' x $indent;
        my $display = "$tab\(\n";

        for my $row (@rows)
        {
            $display .= "$tab    \[" . join( ', ', @$row ) . "]\n";
        }

        return $display . "$tab)";
    }

    #---------------------------------------------------------------------------
    submethod BUILD( Ref[Array] :$bitstrs )
    #---------------------------------------------------------------------------
    {
        my $width = length $bitstrs->[0];

        scalar @$bitstrs == $width   or die 'Matrix not square';

        for my $bitstr (@$bitstrs)
        {
            length $bitstr == $width or die qq[Matrix not square at "$bitstr"];

            push @rows, [ split //, $bitstr ];
        }
    }
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @party = @ARGV;
        my $width = length $party[0];

        scalar @party == $width
                or error( 'Matrix not square' );

        for my $bitstr (@party)
        {
            $bitstr =~ / ^ [01]+ $ /x
                or error( qq[Invalid bitstring "$bitstr"] );

            length $bitstr == $width
                or error( qq[Matrix not square at "$bitstr"] );
        }

        my $matrix = Matrix->new( bitstrs => \@party );

        printf "Input:  \@party =\n%s;\n", $matrix->format( 8 );

        my $celebrity = $matrix->find_celebrity;

        print  "Output: $celebrity\n";
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $party_str, $expected) = split / \| /x, $line;

        for ($test_name, $party_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @party_rows = split / \s+ /x, $party_str;
        my $matrix     = Matrix->new( bitstrs => \@party_rows );
        my $celebrity  = $matrix->find_celebrity;

        is $celebrity, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|000010 000010 000010 000010 000000 000010| 4
Example 2|0100   0010   0001   1000                |-1
Example 3|00000  10000  10000  10000  10000        | 0
Example 4|010101 101100 000110 000000 010100 101100| 3
Example 5|0110   1010   0000   0000                |-1
Example 6|0011   1000   1101   1100                |-1
