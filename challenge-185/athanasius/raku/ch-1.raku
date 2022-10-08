use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 185
=========================

TASK #1
-------
*MAC Address*

Submitted by: Mohammad S Anwar

You are given MAC address in the form i.e. hhhh.hhhh.hhhh.

Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.

Example 1

  Input:  1ac2.34f0.b1c2
  Output: 1a:c2:34:f0:b1:c2

Example 2

  Input:  abc1.20f1.345a
  Output: ab:c1:20:f1:34:5a

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no arguments are given on the command-line, the test suite is run.

Note
----
<xdigit> is the Raku predefined character class for hexadecimal digits [1].

Reference
---------
[1] https://docs.raku.org/language/regexes#Predefined_character_classes

=end comment
#==============================================================================

use Test;

subset Hex of Str where * ~~ / ^ <xdigit> $ /;

my UInt constant $TOTAL-DIGITS = 12;
my UInt constant $DIGIT-SET    =  4;
my UInt constant $TEST-FIELDS  =  3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 185, Task #1: MAC Address (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Str:D $MAC      #= MAC address in the form "hhhh.hhhh.hhhh" (h = hex digit)
)
#==============================================================================
{
    "Input:  $MAC".put;

    my Hex @hex = validate-hex\( $MAC );
    my Str $out = insert-colons( @hex );

    "Output: $out".put;
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($name, $in, $exp) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        is insert-colons( validate-hex( $in ) ), $exp, $name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub validate-hex( Str:D $MAC --> List:D[Str:D] )
#------------------------------------------------------------------------------
{
    $MAC ~~ / ^ (<xdigit> ** { $DIGIT-SET }) \.
                (<xdigit> ** { $DIGIT-SET }) \.
                (<xdigit> ** { $DIGIT-SET }) $ /
        or error( 'Invalid MAC address' );

    return $/.join( '' ).split( '', :skip-empty ).list;
}

#------------------------------------------------------------------------------
sub insert-colons
(
    List:D[Hex:D] $hex where { .elems == $TOTAL-DIGITS }
--> Str:D
)
#------------------------------------------------------------------------------
{
    my Str  $out   = '';
    my UInt $count =  0;

    for @$hex -> Hex $h
    {
        $out ~= $h;
        $out ~= ':' if ++$count %% 2;
    }

    return $out.chop;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,   1ac2.34f0.b1c2, 1a:c2:34:f0:b1:c2
        Example 2,   abc1.20f1.345a, ab:c1:20:f1:34:5a
        Capitals,    1AC2.34F0.B1C2, 1A:C2:34:F0:B1:C2
        Digits only, 0123.4567.8901, 01:23:45:67:89:01
        Mix,         0a1B.2c3D.4e5F, 0a:1B:2c:3D:4e:5F
        END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR:  $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
