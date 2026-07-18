#!perl

################################################################################
=comment

Perl Weekly Challenge 382
=========================

TASK #2
-------
*Replace Question Mark*

Submitted by: Simon Green

You are given a string that contains only 0, 1 and ? characters.

Write a script to generate all possible combinations when replacing the question
marks with a zero or one.

Example 1

  Input: $str = "01??0"
  Output: ("01000", "01010", "01100", "01110")

Example 2

  Input: $str = "101"
  Output: ("101")

Example 3

  Input: $str = "???"
  Output: ("000", "001", "010", "011", "100", "101", "110", "111")

Example 4

  Input: $str = "1?10"
  Output: ("1010", "1110")

Example 5

  Input: $str = "1?1?0"
  Output: ("10100", "10110", "11100", "11110")

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string containing only the characters "0", "1", and "?" is entered on the
   command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string containing only the characters "0", "1", and "?"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 382, Task #2: Replace Question Mark (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $str =  $ARGV[0];
           $str =~ / ( [^01?] ) /x
                        and error( qq[Invalid input character "$1"] );

        print qq[Input:  \$str = "$str"\n];

        my $combs = generate_combinations( $str );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$combs;
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub generate_combinations
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @combs = '';
    my  @chars = split //, $str;

    for my $char (@chars)
    {
        if ($char eq '?')
        {
            my @temp;

            push @temp, $_ . '0', $_ . '1' for @combs;

            @combs = @temp;
        }
        else
        {
            $_ .= $char for @combs;
        }
    }

    return \@combs;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, @expected) = split / \| /x, $line;

        for ($test_name, $str, @expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        push @expected, '' if scalar @expected == 0;

        my $combs = generate_combinations( $str );

        is_deeply $combs, \@expected, $test_name;
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
Example 1|01??0|01000|01010|01100|01110
Example 2|101  |101
Example 3|???  |000|001|010|011|100|101|110|111
Example 4|1?10 |1010|1110
Example 5|1?1?0|10100|10110|11100|11110
Empty str|     |
