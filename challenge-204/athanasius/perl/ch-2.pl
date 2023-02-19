#!perl

###############################################################################
=comment

Perl Weekly Challenge 204
=========================

TASK #2
-------
*Reshape Matrix*

Submitted by: Mohammad S Anwar

You are given a matrix (m x n) and two integers (r) and (c).

Write a script to reshape the given matrix in form (r x c) with the original
value in the given matrix. If you can't reshape print 0.

Example 1

  Input: [ 1 2 ]
         [ 3 4 ]

         $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
         $r = 1
         $c = 4

  Output: [ 1 2 3 4 ]

Example 2

  Input: [ 1 2 3 ]
         [ 4 5 6 ]

         $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
         $r = 3
         $c = 2

  Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]

          [ 1 2 ]
          [ 3 4 ]
          [ 5 6 ]

Example 3

  Input: [ 1 2 ]

         $matrix = [ [ 1, 2 ] ]
         $r = 3
         $c = 2

  Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, and the solution matrix has more than
   one row, then the reshaped matrix is displayed again in two dimensions.
3. Elements in the original matrix are treated as strings, which may contain
   any non-whitespace characters other than "]".
4. The input matrix has the form "[ [ elem_1, elem_2, ... ], [ ... ], ... ]".
   Each row must be enclosed in square brackets. A separator (comma followed by
   optional whitespace) is optional between rows. Within a row, elements must
   be separated by either whitespace or commas (and commas may optionally be
   followed by whitespace). The sequence of rows must itself be enclosed in
   square brackets.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
qq{Usage:
  perl $0 <matrix> <r> <c>
  perl $0

    <matrix>    Matrix represented as a string: "[ [ 1, 2 ], [ 3, 4 ] ]"
    <r>         Number of rows required in the reshaped matrix
    <c>         Number of columns required in the reshaped matrix\n};

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 204, Task #2: Reshape Matrix (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my ($matrix, $r, $c) = parse_command_line();
        my  @matrix          = parse_matrix_string( $matrix );

        printf "Input:  \$matrix = %s\n", format_matrix_1D( \@matrix );
        print  "        \$r = $r\n";
        print  "        \$c = $c\n";

        my $new_matrix = reshape_matrix( \@matrix, $r, $c );

        printf "\nOutput: %s\n", scalar( @$new_matrix ) > 0      ?
                                 format_matrix_1D( $new_matrix ) : '0';

        if ($VERBOSE && scalar( @$new_matrix ) > 1)
        {
            printf "\n%s", format_matrix_2D( $new_matrix, 8 );
        }
    }
}

#------------------------------------------------------------------------------
sub reshape_matrix
#------------------------------------------------------------------------------
{
    my ($matrix, $r, $c) = @_;
    my  $orig_size       = scalar @$matrix * scalar @{ $matrix->[ 0 ] };
    my  @new_matrix;

    if ($r * $c == $orig_size)
    {
        my   @list;
        push @list, @$_ for @$matrix;

        while (@list)
        {
            my   @row;
            push @row, shift @list for 1 .. $c;
            push @new_matrix, [ @row ];
        }
    }

    return \@new_matrix;
}

#------------------------------------------------------------------------------
sub format_matrix_1D
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  $string  = '[ ';
    my  $first   = 1;

    for my $row (@$matrix)
    {
        if ($first)
        {
            $first = 0;
        }
        else
        {
            $string .= ', ';
        }

        $string .= '[ ' . join( ', ', @$row ) . ' ]';
    }

    $string .= ' ]';

    return $string;
}

#------------------------------------------------------------------------------
sub format_matrix_2D
#------------------------------------------------------------------------------
{
    my ($matrix, $offset) = @_;

    my $rows      = scalar @$matrix;
    my $columns   = scalar @{ $matrix->[ 0 ] };
    my @col_width = (0) x $columns;

    for my $i (0 .. $rows - 1)
    {
        for my $j (0 .. $columns - 1)
        {
            my $width = length $matrix->[ $i ][ $j ];

            if ($width > $col_width[ $j ])
            {
                $col_width[ $j ] = $width;
            }
        }
    }

    my $string;

    for my $i (0 .. $rows - 1)
    {
        $string .= ' ' x $offset . '[';
        my $row  = $matrix->[ $i ];

        for my $j (0 .. $columns - 1)
        {
            $string .= sprintf ' %*s', $col_width[ $j ], $row->[ $j ];
        }

        $string .= " ]\n";
    }

    return $string;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 3 or error( "Expected 3 command-line arguments, found $args" );

    my ($matrix, $r, $c) = @ARGV;

    $r =~ / ^ $RE{num}{int} $ /x && $r > 0
                  or error( qq["$r" is not a valid row number] );

    $c =~ / ^ $RE{num}{int} $ /x && $c > 0
                  or error( qq["$c" is not a valid column number] );

    return ($matrix, $r, $c);
}

#------------------------------------------------------------------------------
sub parse_matrix_string
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    $matrix =~ / ^ \s* \[ \s* (.+?) \s* \] \s* $ /x
        or error( 'Malformed matrix string' );

    $matrix  = $1;
    my $cols = -1;
    my @matrix;

    while ($matrix =~ / \G \,? \s* \[ \s* ([^\]]+?) \s* \] /cgx)
    {
        my @row   = split / (?:,\s*|\s+) /x, $1;
        my $elems = scalar @row;

        if    ($elems == 0)
        {
            error( 'Invalid matrix: empty row' );
        }
        elsif ($cols  <  0)
        {
            $cols = $elems;
        }
        elsif ($elems != $cols)
        {
            error( 'Malformed matrix: ragged rows' );
        }

        push @matrix, [ @row ];
    }

    my ($rest) = $matrix =~ / \G (.*) $ /x;
        $rest  =~ / ^ \s* $ /x or error( qq[Malformed matrix string "$rest"] );

    scalar @matrix > 0         or error( 'Empty matrix' );

    return @matrix;
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        if ($line =~ / \\ $ /x)
        {
            my    $next = <DATA>;
            chomp $next;
            chop  $line;

            $line .= $next;
        }

        my ($test_name, $matrix, $r, $c, $expected) = split / \| /x, $line;

        my @old = parse_matrix_string( $matrix );
        my $new = reshape_matrix( \@old, $r, $c );
        my $got = scalar( @$new ) > 0 ? format_matrix_1D( $new ) : 0;

        is $got, $expected, $test_name;
    }

    done_testing;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

__DATA__
Example 1|[ [ 1, 2 ], [ 3, 4 ] ]        |1|4|[ [ 1, 2, 3, 4 ] ]
Example 2|[ [ 1, 2, 3 ], [ 4, 5, 6 ] ]  |3|2|[ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
Example 3|[ [ 1, 2 ] ]                  |3|2|0
Letters 1|[[a,b,c][d,e,f][g,h,i][j,k,l]]|3|4|[ [ a, b, c, d ], [ e, f, g, h ],\
 [ i, j, k, l ] ]
Letters 2|[[a,b,c][d,e,f][g,h,i][j,k,l]]|6|2|[ [ a, b ], [ c, d ], [ e, f ],\
 [ g, h ], [ i, j ], [ k, l ] ]
Letters 3|[[a,b,c][d,e,f][g,h,i][j,k,l]]|2|6|[ [ a, b, c, d, e, f ],\
 [ g, h, i, j, k, l ] ]
