#!perl

################################################################################
=comment

Perl Weekly Challenge 208
=========================

TASK #1
-------
*Minimum Index Sum*

Submitted by: Mohammad S Anwar

You are given two arrays of strings.

Write a script to find out all common strings in the given two arrays with
minimum index sum. If no common strings found returns an empty list.

Example 1

  Input: @list1 = ("Perl", "Raku", "Love")
         @list2 = ("Raku", "Perl", "Hate")

  Output: ("Perl", "Raku")

  There are two common strings "Perl" and "Raku".
  Index sum of "Perl": 0 + 1 = 1
  Index sum of "Raku": 1 + 0 = 1

Example 2

  Input: @list1 = ("A", "B", "C")
         @list2 = ("D", "E", "F")

  Output: ()

  No common string found, so no result.

Example 3

  Input: @list1 = ("A", "B", "C")
         @list2 = ("C", "A", "B")

  Output: ("A")

  There are three common strings "A", "B" and "C".
  Index sum of "A": 0 + 1 = 1
  Index sum of "B": 1 + 2 = 3
  Index sum of "C": 2 + 0 = 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util qw( min );
use Test::More;

const my $SEPARATOR => '-';
const my $USAGE     =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    <string list 1> - <string list 2>\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 208, Task #1: Minimum Index Sum (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if ($args == 0)
    {
        run_tests();
    }
    else
    {
        my ($list1, $list2) = parse_command_line( @ARGV );

        printf "Input: \@list1 = (%s)\n", format_list( $list1 );
        printf "       \@list2 = (%s)\n", format_list( $list2 );

        my $strings = find_min_idx_strings( $list1, $list2 );

        printf "\nOutput: (%s)\n",        format_list( $strings );
    }
}

#-------------------------------------------------------------------------------
sub find_min_idx_strings
#-------------------------------------------------------------------------------
{
    my ($list1, $list2) = @_;
    my  %common;

    OUTER:
    for my $i (0 .. $#$list1)
    {
        my $elem1 = $list1->[ $i ];

        for my $j (0 .. $#$list2)
        {
            my $elem2 = $list2->[ $j ];

            if ($elem1 eq $elem2)
            {
                push @{ $common{ $i + $j } }, $elem1;
                next OUTER;
            }
        }
    }

    my $min_idx = min keys %common;

    return defined $min_idx ? $common{ $min_idx } : [];
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my @args = @_;
    my $idx  = -1;

    for my $i (0 .. $#args)
    {
        if ($args[ $i ] eq $SEPARATOR)
        {
            $idx = $i;
            last;
        }
    }

    $idx >= 0 or error( qq[Missing list separator "$SEPARATOR"] );

    return ([ @args[ 0        .. $idx - 1 ] ],
            [ @args[ $idx + 1 .. $#args   ] ]);
}

#-------------------------------------------------------------------------------
sub format_list
#-------------------------------------------------------------------------------
{
    my ($list) = @_;

    return join ', ', map { qq["$_"] } @$list;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split / \| /x, $line;

        $test_name =~ s/ \s+ $ //x;

        my  @args           = split / \s+ /x, $input;
        my ($list1, $list2) = parse_command_line( @args );
        my  $strings        = find_min_idx_strings( $list1, $list2 );
        my  $got            = join ' ', @$strings;

        is $got, $expected, $test_name;
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
Example 1|Perl Raku Love - Raku Perl Hate|Perl Raku
Example 2|A B C          - D E F         |
Example 3|A B C          - C A B         |A
