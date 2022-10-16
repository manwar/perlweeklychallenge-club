#!perl

###############################################################################
=comment

Perl Weekly Challenge 186
=========================

TASK #1
-------
*Zip List*

Submitted by: Mohammad S Anwar

You are given two list @a and @b of same size.

Create a subroutine sub zip(@a, @b) that merge the two list as shown in the
example below.

Example

  Input:  @a = qw/1 2 3/; @b = qw/a b c/;
  Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
          zip(@b, @a) should return qw/a 1 b 2 c 3/;

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no arguments are given on the command-line, the test suite is run.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $TEST_FIELDS => 4;
const my $USAGE       =>
"Usage:
  perl $0 <a> <b>
  perl $0

    <a>    String representing \@a, with list elements separated by whitespace
    <b>    String representing \@b, with list elements separated by whitespace
";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 186, Task #1: Zip List (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 2)
    {
        my ($a_ref, $b_ref) = parse_command_line();

        printf "Input:  \@a = (%s); \@b = (%s)\n",
            join( ', ', @$a_ref ), join( ', ', @$b_ref );

        printf "Output: zip(\@a, \@b) = (%s)\n",
            join  ', ', @{ zip( $a_ref, $b_ref ) };
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub zip
#------------------------------------------------------------------------------
{
    my ($a_ref, $b_ref) = @_;
    my  @zipped;

    for my $i (0 .. $#$a_ref)
    {
        push @zipped, $a_ref->[ $i ], $b_ref->[ $i ];
    }

    return \@zipped;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my @a = split /\s+/, $ARGV[ 0 ];
    my @b = split /\s+/, $ARGV[ 1 ];

    scalar @a == scalar @b
        or error( 'The lists must be the same size' );

    return (\@a, \@b);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($name, $in1, $in2, $exp)
                 = split / , \s* /x, $line, $TEST_FIELDS;
        my  @a   = split /\s+/, $in1;
        my  @b   = split /\s+/, $in2;
        my  $out = join  ' ', @{ zip( \@a, \@b ) };

        is $out, $exp, $name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1, 1 2 3,               a b c,        1 a 2 b 3 c
Example 2, a b c,               1 2 3,        a 1 b 2 c 3
Odd/even,  1 3 5 7 9,           2 4 6 8 10,   1 2 3 4 5 6 7 8 9 10
Sentence,  There's than way do, more 1 to it, There's more than 1 way to do it
