#!perl

################################################################################
=comment

Perl Weekly Challenge 255
=========================

TASK #1
-------
*Odd Character*

Submitted by: Mohammad Sajid Anwar

You are given two strings, $s and $t. The string $t is generated using the
shuffled characters of the string $s with an additional character.

Write a script to find the additional character in the string $t.

Example 1

  Input: $s = "Perl" $t = "Preel"
  Output: "e"

Example 2

  Input: $s = "Weekly" $t = "Weeakly"
  Output: "a"

Example 3

  Input: $s = "Box" $t = "Boxy"
  Output: "y"

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
2. If $CASE_SENSITIVE is set to a true value, "P" and "p" (for example) are
   treated as different characters; otherwise, they are treated as the same
   character.

=cut
#===============================================================================

use v5.32.1;             # Enables strictures
use warnings;
use Const::Fast;
use Set::Bag;
use Test::More;

const my $ASSERT         => 1;                  # Perform optional sanity checks
const my $CASE_SENSITIVE => 1;
const my $USAGE          => <<END;
Usage:
  perl $0 <s> <t>
  perl $0

    <s>    A string
    <t>    A string containing the chars of s with 1 additional char
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 255, Task #1: Odd Character (Perl)\n\n";
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
        my ($s, $t) = @ARGV;

        print qq[Input:  \$s = "$s" \$t = "$t"\n];

        my $odd_char = find_odd_character( $s, $t );

        print qq[Output: "$odd_char"\n];
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_odd_character
#-------------------------------------------------------------------------------
{
    my ($s, $t) = @_;

    length $t == 1 + length $s
        or error( '$t must be exactly 1 character longer than $s' );

    my %s_chars;
     ++$s_chars{ $_ } for map { $CASE_SENSITIVE ? $_ : lc } split //, $s;

    my %t_chars;
     ++$t_chars{ $_ } for map { $CASE_SENSITIVE ? $_ : lc } split //, $t;

    is_subset( \%s_chars, \%t_chars )
        or error( 'The chars in $s are not a subset of the chars in $t' );

    my $s_bag = Set::Bag->new( %s_chars );
    my $t_bag = Set::Bag->new( %t_chars );
    my $diff  = $t_bag - $s_bag;                                # Set difference

    if ($ASSERT)                                                # Sanity checks
    {
        my @odd_chars = $diff->elements;

        scalar @odd_chars >  0 or error( 'No odd character found' );
        scalar @odd_chars == 1 or error( 'More than 1 odd character found' );

        my $odd_char = $odd_chars[ 0 ];

        $diff->grab( $odd_char ) == 1
            or error( qq[More than 1 odd character "$odd_char" found] );
    }

    return ($diff->elements)[ 0 ];
}

#-------------------------------------------------------------------------------
sub is_subset                                  # Not necessarily a proper subset
#-------------------------------------------------------------------------------
{
    my ($x, $y) = @_;                                            # Hash pointers

    for my $char (keys %$x)
    {
        if (exists $y->{ $char })
        {
            return 0 if $x->{ $char } > $y->{ $char };
        }
        else
        {
            return 0;
        }
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $s, $t, $expected) = split / \| /x, $line;

        for ($test_name, $s, $t, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $odd_char = find_odd_character( $s, $t );

        is $odd_char, $expected, $test_name;
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
Example 1|Perl  |Preel  |e
Example 2|Weekly|Weeakly|a
Example 3|Box   |Boxy   |y
Empty    |      |q      |q
