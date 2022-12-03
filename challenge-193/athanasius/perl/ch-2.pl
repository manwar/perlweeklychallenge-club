#!perl

###############################################################################
=comment

Perl Weekly Challenge 193
=========================

TASK #2
-------
*Odd String*

Submitted by: Mohammad S Anwar

You are given a list of strings of same length, @s.

Write a script to find the odd string in the given list. Use positional value
of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.

    Find the difference array for each string as shown in the example. Then
    pick the odd one out.

Example 1:

  Input: @s = ("adc", "wzy", "abc")
  Output: "abc"

  Difference array for "adc" => [ d - a, c - d ]
                             => [ 3 - 0, 2 - 3 ]
                             => [ 3, -1 ]

  Difference array for "wzy" => [ z - w, y - z ]
                             => [ 25 - 22, 24 - 25 ]
                             => [ 3, -1 ]

  Difference array for "abc" => [ b - a, c - b ]
                             => [ 1 - 0, 2 - 1 ]
                             => [ 1, 1 ]

  The difference array for "abc" is the odd one.

Example 2:

  Input: @s = ("aaa", "bob", "ccc", "ddd")
  Output: "bob"

  Difference array for "aaa" => [ a - a, a - a ]
                             => [ 0 - 0, 0 - 0 ]
                             => [ 0, 0 ]

  Difference array for "bob" => [ o - b, b - o ]
                             => [ 14 - 1, 1 - 14 ]
                             => [ 13, -13 ]

  Difference array for "ccc" => [ c - c, c - c ]
                             => [ 2 - 2, 2 - 2 ]
                             => [ 0, 0 ]

  Difference array for "ddd" => [ d - d, d - d ]
                             => [ 3 - 3, 3 - 3 ]
                             => [ 0, 0 ]

  The difference array for "bob" is the odd one.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. To show the difference array for each string, set $VERBOSE to a true value.
   (This has no effect on the running of the test suite.)

Assumptions
-----------
1. The input list contains at least three strings.
2. Valid input strings are non-empty, and consist of lower case letters only.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $TEST_FLDS => 3;
const my $VERBOSE   => 1;
const my $USAGE     =>
"Usage:
  perl $0 [<s> ...]
  perl $0

    [<s> ...]    A list of 3+ same-length strings of lower case letters\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 193, Task #2: Odd String (Perl)\n\n";
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
    elsif ($args <  3)
    {
        error( "Expected 0 or 3+ arguments, found $args" );
    }
    else
    {
        my @s   = @ARGV;
        my $s0  = $s[ 0 ];
        my $len = length $s0;

        for my $s (@s)
        {
            $s =~ / ^ [a-z]+ $ /x
                or error( qq["$s" is not a valid string] );

            length $s == $len
                or error( qq[Strings "$s0" and "$s" have different lengths] );
        }

        printf "Input:  \@s = (%s)\n", join ', ', map { qq["$_"] } @s;

        my ($odd, $diffs) = find_odd_string( \@s );

        print "Output: $odd\n";

        print_diff_arrays( $diffs ) if $VERBOSE;
    }
}

#------------------------------------------------------------------------------
sub find_odd_string
#------------------------------------------------------------------------------
{
    my ($s)     =  @_;
    my  $diffs  =  get_all_diff_arrays( $s );
    my  $odd    = 'None';
    my  $elems  =  scalar @$s;
    my  $ndiffs =  scalar keys %$diffs;
    my  $done   =  0;

    if    ($ndiffs == 1)
    {
        $odd .= " (all $elems strings have the same difference array)";
        $done = 1;
    }
    elsif ($ndiffs == 2)
    {
        for my $list (values %$diffs)
        {
            if (scalar @$list == 1)
            {
                $odd  = '"' . $list->[ 0 ] . '"';
                $done = 1;
                last;
            }
        }
    }

    $odd .= " (the $elems strings have $ndiffs distinct difference arrays)"
        unless $done;

    return ($odd, $diffs);
}

#------------------------------------------------------------------------------
sub get_all_diff_arrays
#------------------------------------------------------------------------------
{
    my ($s) = @_;
    my  %diff_arrays;

    for my $str (@$s)
    {
        my $diffs = get_one_diff_array( $str );
        my $gist  = '[ ' . join( ', ', @$diffs ) . ' ]';

        push @{ $diff_arrays{ $gist } }, $str;
    }

    return \%diff_arrays;
}

#------------------------------------------------------------------------------
sub get_one_diff_array
#------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  @chars = split //, $str;
    my  @diffs;

    for my $i (1 .. length( $str ) - 1)
    {
        push @diffs, ord( $chars[ $i ] ) - ord( $chars[ $i - 1 ] );
    }

    return \@diffs;
}

#------------------------------------------------------------------------------
sub print_diff_arrays
#------------------------------------------------------------------------------
{
    my ($da2strs) = @_;
    my  %str2da;

    while (my ($key, $value) = each %$da2strs)               # Reverse the hash
    {
        for my $str (@$value)
        {
            $str2da{ $str } = $key;
        }
    }

    print "\n  Difference arrays:\n";

    for my $str (sort keys %str2da)
    {
        printf qq[    "%s" => %s\n], $str, $str2da{ $str };
    }
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

        if ($line =~ s/ \\ $ //x)
        {
            $line .= <DATA>;
            redo;
        }

        my ($test_name, $in, $expected) = split / , \s* /x, $line, $TEST_FLDS;

        my  @list = split / \s+ /x, $in;

        my ($odd, undef) = find_odd_string( \@list );

        is  $odd, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1, adc wzy abc,     abc
Example 2, aaa bob ccc ddd, bob
All same,  adc wzy vyx bed,     \
           None (all 4 strings have the same difference array)
Two odd,   mor jlo abc def,     \
           None (the 4 strings have 2 distinct difference arrays)
All odd,   abc acd ade aef afg, \
           None (the 5 strings have 5 distinct difference arrays)
Odd plus,  adc wzy abc jop kpq, \
           None (the 5 strings have 3 distinct difference arrays)
