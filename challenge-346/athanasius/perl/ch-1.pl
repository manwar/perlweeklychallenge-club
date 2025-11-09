#!perl

################################################################################
=comment

Perl Weekly Challenge 346
=========================

TASK #1
-------
*Longest Parenthesis*

Submitted by: Mohammad Sajid Anwar

You are given a string containing only ( and ).

Write a script to find the length of the longest valid parenthesis.

Example 1

  Input: $str = '(()())'
  Output: 6

  Valid Parenthesis: '(()())'

Example 2

  Input: $str = ')()())'
  Output: 4

  Valid Parenthesis: '()()' at positions 1-4.

Example 3

  Input: $str = '((()))()(((()'
  Output: 8

  Valid Parenthesis: '((()))()' at positions 0-7.

Example 4

  Input: $str = '))))((()('
  Output: 2

  Valid Parenthesis: '()' at positions 6-7.

Example 5

  Input: $str = '()(()'
  Output: 2

  Valid Parenthesis: '()' at positions 0-1 and 3-4.

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
2. A single string, containing only left and right parentheses, is entered on
   the command-line.

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

    <str>    A string containing only ( and )
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 346, Task #1: Longest Parenthesis (Perl)\n\n";
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
           $str =~ / ^ [()]* $ /x or error( 'The input string is invalid' );

        print "Input:  \$str = '$str'\n";

        my $len = find_longest_paren_len( $str );

        print "Output: $len\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_longest_paren_len
#-------------------------------------------------------------------------------
{
    my ($str)     =  @_;
        $str      =~ m/ ^ [()]* $ /x or die 'Invalid string';
        $str      =~ s/ ^ \)+   //x;
        $str      =~ s/   \(+ $ //x;
    my  $max_len  =  0;
    my  $last_idx =  length( $str ) - 1;
    my  $start    =  0;
    my  $last_end = -2;
    my  $last_len =  0;

    while ($start < $last_idx)
    {
        my $count = 1;
        my $found = 0;

        for my $end ($start + 1 .. $last_idx)
        {
            if    (substr( $str, $end, 1 ) eq '(')
            {
                ++$count;
            }
            elsif (--$count == 0)      # Match found
            {
                my  $len  = $end - $start + 1;
                    $len += $last_len if $start == $last_end + 1;
                $max_len  = $len      if $len > $max_len;
                $last_end = $end;
                $last_len = $len;
                $found    = 1;
                $start    = $end + 1;

                ++$start while substr( $str, $start, 1 ) eq ')';

                last;
            }
        }

        ++$start unless $found;        # No match: advance 1 char & search again
    }

    return $max_len;
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

        my $len = find_longest_paren_len( $str );

        is $len, $expected, $test_name;
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
Example 1|(()())       |6|(()())
Example 2|)()())       |4|()()     at positions 1-4
Example 3|((()))()(((()|8|((()))() at positions 0-7
Example 4|))))((()(    |2|()       at positions 6-7
Example 5|()(()        |2|()       at positions 0-1 and 3-4
2 matches|())(())      |4|(())     at positions 3-6
