#!perl

################################################################################
=comment

Perl Weekly Challenge 239
=========================

TASK #2
-------
*Consistent Strings*

Submitted by: Mohammad S Anwar

You are given an array of strings and allowed string having distinct characters.

    A string is consistent if all characters in the string appear in the string
    allowed.

Write a script to return the number of consistent strings in the given array.

Example 1

  Input: @str = ("ad", "bd", "aaab", "baa", "badab")
         $allowed = "ab"
  Output: 2

  Strings "aaab" and "baa" are consistent since they only contain characters 'a'
  and 'b'.

Example 2

  Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
         $allowed = "abc"
  Output: 7

Example 3

  Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
         $allowed = "cad"
  Output: 4

  Strings "cc", "acd", "ac", and "d" are consistent.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $CASE_SENSITIVE is set to a false value (the default), an "a" in the
   allowed string matches both "a" and "A" in any string in the input list. If
   $CASE_INSENSITIVE is set to a true value, the case must also match.
3. If $VERBOSE is set to a true value (the default), the output (i.e., the count
   of consistent strings) is followed by a list of the consistent strings found
   (if any).

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use Getopt::Long;
use Set::Scalar;
use Test::More;

const my $CASE_SENSITIVE => 0;
const my $VERBOSE        => 1;
const my $USAGE          =>
"Usage:
  perl $0 [--allowed=<Str>] [<strings> ...]
  perl $0

    --allowed=<Str>    Non-empty string of allowed characters
    [<strings> ...]    List of strings\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 239, Task #2: Consistent Strings (Perl)\n\n";
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
        my ($allowed, $strings) = parse_command_line();

        printf qq[Input:  \@strings = (%s)\n], format_as_list( $strings );
        print  qq[        \$allowed =  "$allowed"\n];

        my $con_strs = find_consistent_strings( $strings, $allowed );
        my $count    = scalar @$con_strs;

        print  "Output: $count\n";

        printf "\nConsistent strings: %s\n", format_as_list( $con_strs )
            if $VERBOSE && $count > 0;
    }
}

#-------------------------------------------------------------------------------
sub find_consistent_strings
#-------------------------------------------------------------------------------
{
    my ($strs, $allowed) = @_;
    my  @allowed_chars   = split //, $allowed;
        @allowed_chars   = map { lc, uc } @allowed_chars unless $CASE_SENSITIVE;
    my  $allowed_chars   = Set::Scalar->new( @allowed_chars );
    my  @consistent_strs;

    for my $string (@$strs)
    {
        my $chars = Set::Scalar->new( split //, $string );

        push @consistent_strs, $string if $chars->is_subset( $allowed_chars );
    }

    return \@consistent_strs;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $allowed;

    GetOptions( 'allowed=s' => \$allowed )
        or error( 'Invalid command line argument' );

    defined $allowed
        or error( 'Input string of allowed characters is missing' );

    return ($allowed, \@ARGV);
}

#-------------------------------------------------------------------------------
sub format_as_list
#-------------------------------------------------------------------------------
{
    my ($strings) = @_;

    return join ', ', map { qq["$_"] } @$strings;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $strings, $allowed, $exp_count, $exp_con_strs) =
             split / \| /x, $line;

        for ($test_name, $strings, $allowed, $exp_count, $exp_con_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @strings      = split / \s+ /x, $strings;
        my @exp_con_strs = split / \s+ /x, $exp_con_strs;
        my $con_strs     = find_consistent_strings( \@strings, $allowed );

        is scalar @$con_strs,  $exp_count,    "$test_name: count";
        is_deeply  $con_strs, \@exp_con_strs, "$test_name: consistent strings";
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
Example 1|ad bd aaab baa badab    |ab |2|aaab baa
Example 2|a b c ab ac bc abc      |abc|7|a b c ab ac bc abc
Example 3|cc acd b ba bac bad ac d|cad|4|cc acd ac d
