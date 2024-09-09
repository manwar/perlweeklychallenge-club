#!perl

################################################################################
=comment

Perl Weekly Challenge 285
=========================

TASK #1
-------
*No Connection*

Submitted by: Mohammad Sajid Anwar

You are given a list of routes, @routes.

Write a script to find the destination with no further outgoing connection.

Example 1

  Input: @routes = (["B","C"], ["D","B"], ["C","A"])
  Output: "A"

  "D" -> "B" -> "C" -> "A".
  "B" -> "C" -> "A".
  "C" -> "A".
  "A".

Example 2

  Input: @routes = (["A","Z"])
  Output: "Z"

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
2. A single string is entered on the command-line: this string consists of
   routes separated by semicolons; each route consists of exactly two strings
   separated by whitespace.

Assumptions
-----------
1. There may be more than one terminus.
2. A cycle has no terminus, e.g., "A" -> "B" -> "C" -> "A".
3. "A" -> "A" is a cycle.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <routes>
  perl $0

    <routes>    String of routes, e.g., "X Y; Z A; A B; W X"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 285, Task #1: No Connection (Perl)\n\n";
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
        my $routes = parse_routes_str( $ARGV[ 0 ] );

        printf "Input:  \@routes = (%s)\n",
                join ', ', map { qq(["$_->[ 0 ]","$_->[ 1 ]"]) } @$routes;

        my $termini = find_termini( $routes );

        printf "Output: %s\n",
                @$termini ? join( ', ', map { qq["$_"] } @$termini ) : '<none>';
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_termini
#-------------------------------------------------------------------------------
{
    my ($routes) = @_;
    my  %count;

    for my $route (@$routes)
    {
        my ($lhs, $rhs) = @$route;

        ++$count{ $lhs };

        exists $count{ $rhs } or $count{ $rhs } = 0;
    }

    my @termini;

    for my $node (keys %count)
    {
        push @termini, $node if $count{ $node } == 0;
    }

    @termini = sort @termini;

    return \@termini;
}

#-------------------------------------------------------------------------------
sub parse_routes_str
#-------------------------------------------------------------------------------
{
    my ($routes_str) = @_;
    my  @routes;

    for my $route_str (split / \; /x, $routes_str)
    {
        my ($lhs, $rhs) = $route_str =~ / ^ \s* (\S+) \s+ (\S+) \s* $ /x
            or  error( qq[Invalid route "$route_str"] );

        push @routes, [ $lhs => $rhs ];
    }

    return \@routes;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $routes_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $routes_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $routes   = parse_routes_str( $routes_str );
        my $termini  = find_termini( $routes );
        my @expected = split / \s+ /x, $expected_str;

        is_deeply $termini, \@expected, $test_name;
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
Example 1    |B C; D B; C A|A
Example 2    |A Z          |Z
Trivial cycle|A A          |
Long cycle   |A B; B C; C A|
Forest       |A B; B C; D E|C E
