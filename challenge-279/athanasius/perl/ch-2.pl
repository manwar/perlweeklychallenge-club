#!perl

################################################################################
=comment

Perl Weekly Challenge 279
=========================

TASK #2
-------
*Split String*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to split the given string into two containing exactly same number
of vowels and return true if you can otherwise false.

Example 1

  Input: $str = "perl"
  Output: false

Example 2

  Input: $str = "book"
  Output: true

  Two possible strings "bo" and "ok" containing exactly one vowel each.

Example 3

  Input: $str = "good morning"
  Output: true

  Two possible strings "good " and "morning" containing two vowels each or
  "good m" and "orning" containing two vowels each.

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
2. If an explanation of the output (i.e., one possible solution) is wanted,
   "--verbose" is entered as a command-line flag.
3. A single string is given as the last entry on the command-line.

=cut
#===============================================================================

use v5.36;   # Enables strictures and warnings
no  warnings qw( experimental::builtin );
use builtin  qw( true false floor ceil trim );
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $NON_VOWEL => qr/ [^AEIOU] /ix;
const my $VOWEL     => qr/  [AEIOU] /ix;
const my $USAGE     => <<END;
Usage:
  perl $0 [--verbose] <str>
  perl $0

    <str>        A string
    --verbose    Explain the output? [default: False]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 279, Task #2: Split String (Perl)\n\n";
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
        my ($str, $verbose) = parse_command_line();

        print qq[Input:  \$str = "$str"\n];

        my ($can_split, $lhs, $rhs, $vowels) = split_string( $str, $verbose );

        printf "Output: %s\n", $can_split ? 'true' : 'false';

        if ($verbose && $can_split)
        {
            print   "\nThis is a solution:\n";
            printf qq["%s" and "%s" each contain %d vowel%s\n],
                   $lhs, $rhs, $vowels, $vowels == 1 ? '' : 's';
        }
    }
}

#-------------------------------------------------------------------------------
sub split_string
#-------------------------------------------------------------------------------
{
    my ($str, $verbose) = @_;
    my  $can_split      = false;
    my  $lhs            = '';
    my  $rhs            = '';
    my  $vowel_str      = $str =~ s/ $NON_VOWEL //grx;
    my  $n_vowels       = length $vowel_str;
    my  $target         = 0;

    if ($n_vowels % 2 == 0)
    {
        $can_split = true;

        if ($verbose)
        {
            if ($n_vowels == 0)
            {
                my $i = ceil( length( $str ) / 2 );

                $lhs = substr $str, 0, $i;
                $rhs = substr $str, $i;
            }
            else
            {
                ($lhs, $rhs, $target) = perform_split( $str, $n_vowels );
            }
        }
    }

    return $can_split, $lhs, $rhs, $target;
}

#-------------------------------------------------------------------------------
sub perform_split
#-------------------------------------------------------------------------------
{
    my ($str, $n_vowels) = @_;
    my  $target = floor( $n_vowels / 2 );
    my  @chars  = split //, $str;
    my  $lhs    = '';
    my  $rhs    = '';
    my  $v      =  0;

    for my $i (0 .. $#chars)
    {
        if ($chars[ $i ] =~ / $VOWEL /x && ++$v == $target)
        {
            $lhs = join '', @chars[ 0      .. $i      ];
            $rhs = join '', @chars[ $i + 1 .. $#chars ];
            last;
        }
    }

    $rhs  =~ / ^ ( $NON_VOWEL* ) /x;
    my $w = ceil( length( $1 ) / 2 );
    $lhs .= substr $rhs, 0, $w;
            substr $rhs, 0, $w, '';

    return $lhs, $rhs, $target;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $verbose = 0;

    GetOptions
    (
        verbose => \$verbose

    )          or error( 'Error in command line arguments' );

    my $argc = scalar @ARGV;

    $argc == 1 or error( "Expected 1 command-line argument, found $argc" );

    return $ARGV[ 0 ], $verbose;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $str, $exp_can, $exp_lhs, $exp_rhs) = split /\|/, $line;

        $_ = trim $_ for $test_name, $str, $exp_can, $exp_lhs, $exp_rhs;
        s/_/ /g      for             $str,           $exp_lhs, $exp_rhs;

        my ($can_split, $lhs, $rhs) = split_string( $str, true );

        is  $can_split, $exp_can, $test_name;

        if ($can_split)
        {
            is $lhs, $exp_lhs, $test_name;
            is $rhs, $exp_rhs, $test_name;
        }
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

# An initial or trailing space in the input and output strings is represented by
# an underscore (e.g., "good_ " represents "good ")

__DATA__
Example 1  |perl        | |      |
Example 2  |book        |1|bo    |ok
Example 3  |good morning|1|good_ |morning
No vowels 1|BcdfghJklmnp|1|Bcdfgh|Jklmnp
No vowels 2|BcdfghJklmn |1|Bcdfgh|Jklmn
All vowels |aeiouAEIOU  |1|aeiou |AEIOU
Empty      |            |1|      |
