#!perl

################################################################################
=comment

Perl Weekly Challenge 328
=========================

TASK #1
-------
*Replace all ?*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and ?.

Write a script to replace all ? in the given string so that the string doesn’t
contain consecutive repeating characters.

Example 1

  Input: $str = "a?z"
  Output: "abz"

  There can be many strings, one of them is "abz".
  The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the
  '?'.

Example 2

  Input: $str = "pe?k"
  Output: "peak"

Example 3

  Input: $str = "gra?te"
  Output: "grabte"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string containing only lower case English letters and "?" is entered on the
   command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string containing only lower case English letters and "?"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 328, Task #1: Replace all ? (Perl)\n\n";
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
        my $str = $ARGV[ 0 ];

        $str =~ / ^ [a-z?]* $ /x or error( 'Invalid string' );

        print qq[Input: \$str = "$str"\n];

        my $replaced = replace_queries( $str );

        print qq[Output:       "$replaced"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub replace_queries
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
        $str  =~ / ^ [a-z?]* $ /x or die 'Invalid string';

    my  $replaced = '';
    my  @chars    = split //, $str;

    for my $i (0 .. $#chars)
    {
        my $char = $chars[ $i ];

        if ($char eq '?')
        {
            for my $new ('a' .. 'z')
            {
                if (($i == 0       || $new ne $chars[ $i - 1 ]) &&
                    ($i == $#chars || $new ne $chars[ $i + 1 ]))
                {
                    $char = $chars[ $i ] = $new;
                    last;
                }
            }
        }

        $replaced .= $char;
    }

    return $replaced;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $replaced = replace_queries( $str );

        is $replaced, $expected, $test_name;
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
Example 1 |a?z   |abz
Example 2 |pe?k  |peak
Example 3 |gra?te|grabte
Adjacent ?|ab??cd|ababcd
All ?     |????? |ababa
