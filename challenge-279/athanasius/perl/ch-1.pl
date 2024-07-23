#!perl

################################################################################
=comment

Perl Weekly Challenge 279
=========================

TASK #1
-------
*Sort Letters*

Submitted by: Mohammad Sajid Anwar

You are given two arrays, @letters and @weights.

Write a script to sort the given array @letters based on the @weights.

Example 1

  Input: @letters = ('R', 'E', 'P', 'L')
         @weights = (3, 2, 1, 4)
  Output: PERL

Example 2

  Input: @letters = ('A', 'U', 'R', 'K')
         @weights = (2, 4, 1, 3)
  Output: RAKU

Example 3

  Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
         @weights = (5, 4, 2, 6, 1, 3)
  Output: PYTHON

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input lists are entered as two strings on the command-line. The first
   string contains only letters; the second string contains positive (non-zero)
   integers separated by whitespace.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <letters> <weights>
  perl $0

    <letters>    A string of letters
    <weights>    A string of whitespace-separated positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 279, Task #1: Sort Letters (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my $letters = parse_letters( $ARGV[ 0 ] );
        my $weights = parse_weights( $ARGV[ 1 ], scalar @$letters );

        printf "Input:  \@letters = (%s)\n", 
                join ', ', map { "'$_'" } @$letters;

        printf "        \@weights = (%s)\n", join ', ', @$weights; 

        my $sorted = sort_letters( $letters, $weights );

        print "Output: $sorted\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub sort_letters
#-------------------------------------------------------------------------------
{
    my ($letters, $weights) = @_;
    my  @sorted;

    for my $i (0 .. $#$letters)
    {
        $sorted[ $weights->[ $i ] - 1 ] = $letters->[ $i ];
    }

    return join '', @sorted;
}

#-------------------------------------------------------------------------------
sub parse_letters
#-------------------------------------------------------------------------------
{
    my ($letters_str) = @_;

    my  @chars = split //, $letters_str;
    my  @letters;

    for my $char (@chars)
    {
        $char =~ / ^ [A-Z] $ /ix or error( qq[Invalid letter "$char"] );

        push @letters, $char;
    }

    return \@letters;
}

#-------------------------------------------------------------------------------
sub parse_weights
#-------------------------------------------------------------------------------
{
    my ($weights_str, $count) = @_;

    my  @nums = split / \s+ /x, $weights_str;
    my  @weights;

    for my $weight (@nums)
    {
        $weight =~ / ^ $RE{num}{int} $ /x
                              or  error( qq[Invalid weight "$weight"] );
        $weight >  0          or  error( "Weight $weight is too small" );
        $weight <= $count     or  error( "Weight $weight is too large" );

        push @weights, $weight;
    }

    scalar @weights == $count or  error( 'The number of weights does not ' .
                                         'match the number of letters' );
    my %dict;
     ++$dict{ $_ } for @weights;

    for my $weight (keys %dict)
    {
        $dict{ $weight } > 1  and error( "Duplicate weight $weight" );
    }

    return \@weights;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $letters_str, $weights_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $letters_str, $weights_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $letters = parse_letters( $letters_str );
        my $weights = parse_weights( $weights_str, scalar @$letters );
        my $sorted  = sort_letters ( $letters, $weights );

        is $sorted, $expected, $test_name;
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
Example 1|REPL  |3 2 1 4    |PERL
Example 2|AURK  |2 4 1 3    |RAKU
Example 3|OHYNPT|5 4 2 6 1 3|PYTHON
