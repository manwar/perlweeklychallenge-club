use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

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

=end comment
#===============================================================================

use Test;

subset Route of List where (Str, Str);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 285, Task #1: No Connection (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $routes                #= String of routes, e.g., "X Y; Z A; A B; W X"
)
#===============================================================================
{
    my @routes = parse-routes-str( $routes );

    "Input:  \@routes = (%s)\n".printf:
        @routes.map( { qq<["$_[ 0 ]","$_[ 1 ]"]> } ).join: ', ';

    my Str @termini = find-termini( @routes );

    "Output: %s\n".printf:
        @termini ?? @termini.map( { qq<"$_"> } ).join( ', ' ) !! '<none>';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-termini( List:D[Route:D] $routes --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my UInt %count{Str};

    for @$routes -> Route $route
    {
        my Str ($lhs, $rhs) = @$route;

        ++%count{ $lhs };

        %count{ $rhs }:exists or %count{ $rhs } = 0;
    }

    my Str @termini;

    for %count.keys -> Str $node
    {
        @termini.push: $node if %count{ $node } == 0;
    }

    @termini .= sort;

    return @termini;
}

#-------------------------------------------------------------------------------
sub parse-routes-str( Str:D $routes-str --> List:D[Route:D] )
#-------------------------------------------------------------------------------
{
    my Route @routes;

    for $routes-str.split( / \; /, :skip-empty ) -> Str $route-str
    {
        $route-str ~~ / ^ \s* (\S+) \s+ (\S+) \s* $ /
            or error( qq<Invalid route "$route-str"> );

        @routes.push: (~$0, ~$1);
    }

    return @routes;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $routes-str, $expected-str) = $line.split: / \| /;

        for     $test-name, $routes-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Route @routes   = parse-routes-str( $routes-str );
        my Str   @termini  = find-termini( @routes );
        my Str   @expected = $expected-str.split: / \s+ /, :skip-empty;

        is-deeply @termini, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1    |B C; D B; C A|A
        Example 2    |A Z          |Z
        Trivial cycle|A A          |
        Long cycle   |A B; B C; C A|
        Forest       |A B; B C; D E|C E
        END
}

################################################################################
