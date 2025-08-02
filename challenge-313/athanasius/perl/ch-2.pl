#!perl

################################################################################
=comment

Perl Weekly Challenge 313
=========================

TASK #2
-------
*Reverse Letters*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to reverse only the alphabetic characters in the string.

Example 1

  Input: $str = "p-er?l"
  Output: "l-re?p"

Example 2

  Input: $str = "wee-k!L-y"
  Output: "yLk-e!e-w"

Example 3

  Input: $str = "_c-!h_all-en!g_e"
  Output: "_e-!g_nel-la!h_c"

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
2. A single string is entered on the command-line.

=cut
#===============================================================================

use v5.32;        # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert qw( on );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 313, Task #2: Reverse Letters (Perl)\n\n";
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

        print qq[Input: \$str = "$str"\n];

        my $reversed = reverse_letters( $str );

        print qq[Output:       "$reversed"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reverse_letters
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @chars = split //, $str;
    my  @alpha;

    for my $i (0 .. $#chars)
    {
        if ($chars[ $i ] =~ / [A-Z] /ix)
        {
            push @alpha, $chars[ $i ];
            $chars[ $i ] = undef;
        }
    }

    for my $i (0 .. $#chars)
    {
        $chars[ $i ] = pop @alpha unless defined $chars[ $i ];
    }

    assert scalar @alpha == 0;

    return join '', @chars;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $str, $expected) = split / \| /x, $line;

        $test_name   =~ s/ \s+ $ //x;
        my $reversed = reverse_letters( $str );

        is $reversed, $expected, $test_name;
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
Example 1|p-er?l|l-re?p
Example 2|wee-k!L-y|yLk-e!e-w
Example 3|_c-!h_all-en!g_e|_e-!g_nel-la!h_c
