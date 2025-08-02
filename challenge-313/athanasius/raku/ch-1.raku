use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string "$name" is entered on the command-line, followed by an actual typed
   string "$typed".

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 313, Task #1: Broken Keys (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $name,                       #= A string
    Str:D $typed                       #= A typed string
)
#===============================================================================
{
    qq[Input:  \$name = "$name", \$typed = "$typed"].put;

    my Bool $is-meant = find-whether-meant( $name, $typed );

    "Output: %s\n".printf: $is-meant ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-whether-meant( Str:D $name, Str:D $typed --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str  @name      = $name\.split: '', :skip-empty;
    my Str  @typed     = $typed.split: '', :skip-empty;
    my UInt $name-len  = @name\.elems;
    my UInt $typed-len = @typed.elems;
    my Str  $name0    := @name[ 0 ];

    $typed-len >= $name-len               or  return False;
    $name-len == 0                        and return $typed-len == 0;
    $name-len == 1 || $name0 eq @name.all and return so $name0 eq @typed.all;
    @typed[   0 ]  eq $name0 &&
    @typed[ *-1 ]  eq @name[ *-1 ]        or  return False;

    my Str ($current, $next) = $name0, @name[ 1 ];
    my UInt $j = 1;

    loop (my UInt $i = 0; $i < @name.end; ++$j)
    {
        if    @typed[ $j ] eq $next
        {
            $current = $next;
            $next    = @name[ ++$i + 1 ];
        }
        elsif @typed[ $j ] ne $current
        {
            return False;
        }
    }

    return so $current eq @typed[ $j .. * ].all;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $name, $typed, $expected-str) = $line.split: / \| /;

        for     $test-name, $name, $typed, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bool $is-meant = find-whether-meant( $name, $typed );
        my Bool $expected = $expected-str eq 'true';

        is $is-meant, $expected, $test-name;
    }

    done-testing;
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
        END
}

################################################################################
