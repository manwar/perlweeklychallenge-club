#!perl

################################################################################
=comment

Perl Weekly Challenge 313
=========================

TASK #1
-------
*Broken Keys*

Submitted by: Mohammad Sajid Anwar

You have a broken keyboard which sometimes type a character more than once.

You are given a string and actual typed string.

Write a script to find out if the actual typed string is meant for the given
string.

Example 1

  Input: $name = "perl", $typed = "perrrl"
  Output: true

  Here "r" is pressed 3 times instead of 1 time.

Example 2

  Input: $name = "raku", $typed = "rrakuuuu"
  Output: true

Example 3

  Input: $name = "python", $typed = "perl"
  Output: false

Example 4

  Input: $name = "coffeescript", $typed = "cofffeescccript"
  Output: true

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
2. A string "$name" is entered on the command-line, followed by an actual typed
   string "$typed".

=cut
#===============================================================================

use v5.32;          # Enables strictures
use warnings;
use Const::Fast;
use List::MoreUtils qw( all );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <name> <typed>
  perl $0

    <name>     A string
    <typed>    A typed string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 313, Task #1: Broken Keys (Perl)\n\n";
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
        my ($name, $typed) = @ARGV;

        print qq[Input:  \$name = "$name", \$typed = "$typed"\n];

        my $is_meant = find_whether_meant( $name, $typed );

        printf "Output: %s\n", $is_meant ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_whether_meant
#-------------------------------------------------------------------------------
{
    my ($name, $typed) = @_;
    my  @name      = split //, $name;
    my  @typed     = split //, $typed;
    my  $name_len  = scalar @name;
    my  $typed_len = scalar @typed;
    my  $name0     = $name[ 0 ];

    $typed_len < $name_len and return '';
    $name_len  == 0        and return $typed_len == 0;
    $name_len  == 1 || all { $_ eq $name0 } @name
                           and return all { $_ eq $name0 } @typed;
    $typed[ 0 ] ne $name0 || $typed[ -1 ]  ne $name[ -1 ]
                           and return '';

    my ($current, $next, $j) = ($name0, $name[ 1 ], 1);

    for (my $i = 0; $i < $#name; ++$j)
    {
        if    ($typed[ $j ] eq $next)
        {
            $current = $next;
            $next    = $name[ ++$i + 1 ];
        }
        elsif ($typed[ $j ] ne $current)
        {
            return '';
        }
    }

    return all { $_ eq $current } @typed[ $j .. $#typed ];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $name, $typed, $expected_str) = split / \| /x, $line;

        for ($test_name, $name, $typed, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $is_meant = find_whether_meant( $name, $typed );
        my $expected = $expected_str eq 'true';

        is $is_meant, $expected, $test_name;
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
Example 1  |perl        |perrrl         |true
Example 2  |raku        |rrakuuuu       |true
Example 3  |python      |perl           |false
Example 4  |coffeescript|cofffeescccript|true
Empty 1    |            |               |true
Empty 2    |            |z              |false
Too small  |Fortran     |Fortra         |false
Singleton 1|j           |j              |true
Singleton 2|k           |kkk            |true
Singleton 3|l           |m              |false
Wrong order|Perl        |Prrell         |false
Penultimate|perl        |perlxl         |false
