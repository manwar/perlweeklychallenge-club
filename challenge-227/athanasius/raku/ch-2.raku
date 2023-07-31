use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 227
=========================

TASK #2
-------
*Roman Maths*

Submitted by: Peter Campbell Smith

Write a script to handle a 2-term arithmetic operation expressed in Roman
numeral.

Example

  IV + V     => IX
  M - I      => CMXCIX
  X / II     => V
  XI * VI    => LXVI
  VII ** III => CCCXLIII
  V - V      => nulla (they knew about zero but didn't have a symbol)
  V / II     => non potest (they didn't do fractions)
  MMM + M    => non potest (they only went up to 3999)
  V - X      => non potest (they didn't do negative numbers)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Notes
-----
1. Roman numerals in lower case will be converted to upper case.
2. A non-standard form such as "IM" is (incorrectly?) interpreted as 1001, not
   999 as might be expected.

=end comment
#===============================================================================

use Math::Roman;
use Test;

my UInt constant $MAX-ROM-NUM  =  3999;
my      constant @OPERATORS    =  Array[Str].new: < + - * / ** >;
my Str  constant $ROM-NUM-ZERO = 'nulla';        # Latin "no", Italian "nothing"
my Str  constant $UNDEFINED    = 'non potest';   # Latin "can not"

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 227, Task #2: Roman Maths (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $operand1,         #= Left operand:  number in Roman numerals
    Str:D $operator,         #= Arithmetic operator: + - * / **
    Str:D $operand2          #= Right operand: number in Roman numerals
)
#===============================================================================
{
    my Str $op1 = $operand1.uc;
    my Str $op2 = $operand2.uc;

    is-roman-num( $op1 )
        or error( qq["$op1" is not a valid Roman numeral] );

    is-operator\( $operator )
        or error( qq["$operator" is not a valid arithmetic operator] );

    is-roman-num( $op2 )
        or error( qq["$op2" is not a valid Roman numeral] );

    "Input:  $op1 $operator $op2".put;

    my Str $result = calculate( $op1, $operator, $op2 );

    "Output: $result".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub calculate( Str:D $operand1, Str:D $operator, Str:D $operand2 --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str         $result;
    my Math::Roman $left-op  = Math::Roman.new: $operand1;
    my Math::Roman $right-op = Math::Roman.new: $operand2;

    given $operator
    {
        when '+'  { $result =            add( $left-op, $right-op ); }
        when '-'  { $result =       subtract( $left-op, $right-op ); }
        when '*'  { $result =       multiply( $left-op, $right-op ); }
        when '/'  { $result =         divide( $left-op, $right-op ); }
        when '**' { $result = raise-to-power( $left-op, $right-op ); }
        default   {  die qq[Invalid operator "$operator"];           }
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub add( Math::Roman:D $left-op, Math::Roman:D $right-op --> Str:D )
#-------------------------------------------------------------------------------
{
    my UInt $sum = $left-op + $right-op;

    return $sum > $MAX-ROM-NUM ?? $UNDEFINED !! to-roman( $sum );
}

#-------------------------------------------------------------------------------
sub subtract( Math::Roman:D $left-op, Math::Roman:D $right-op --> Str:D )
#-------------------------------------------------------------------------------
{
    my Int $difference = $left-op - $right-op;

    return $difference == 0 ?? $ROM-NUM-ZERO !!
           $difference <  0 ?? $UNDEFINED    !! to-roman( $difference );
}

#-------------------------------------------------------------------------------
sub multiply( Math::Roman:D $left-op, Math::Roman:D $right-op --> Str:D )
#-------------------------------------------------------------------------------
{
    my UInt $product = $left-op * $right-op;

    return $product > $MAX-ROM-NUM ?? $UNDEFINED !! to-roman( $product );
}

#-------------------------------------------------------------------------------
sub divide( Math::Roman:D $left-op, Math::Roman:D $right-op --> Str:D )
#-------------------------------------------------------------------------------
{
    my Rat $quotient = $left-op / $right-op;

    return $quotient.denominator == 1 ?? to-roman( $quotient.Int ) !!
                                         $UNDEFINED;
}

#-------------------------------------------------------------------------------
sub raise-to-power( Math::Roman:D $left-op, Math::Roman:D $right-op --> Str:D )
#-------------------------------------------------------------------------------
{
    my UInt $power = $left-op ** $right-op;

    return $power > $MAX-ROM-NUM ?? $UNDEFINED !! to-roman( $power );
}

#-------------------------------------------------------------------------------
sub is-roman-num( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Bool        $valid = True;
    my Math::Roman $roman-num;

    {
        CATCH
        {
            when X::TypeCheck::Return
            {
                $valid = False;
            }
        }

        $roman-num = Math::Roman.new: $str;
    }

    $valid = False if $valid && $roman-num > $MAX-ROM-NUM;

    return $valid;
}

#-------------------------------------------------------------------------------
sub is-operator( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    for @OPERATORS -> Str $op
    {
        return True if $str eq $op;
    }

    return False;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $op1, $opr, $op2, $expected) = $line.split: / \| /;

        for     $test-name, $op1, $opr, $op2, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $result = calculate( $op1, $opr, $op2 );

        is $result, $expected, $test-name;
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
        Example 1     |IV       |+ |V  |IX
        Example 2     |M        |- |I  |CMXCIX
        Example 3     |X        |/ |II |V
        Example 4     |XI       |* |VI |LXVI
        Example 5     |VII      |**|III|CCCXLIII
        Example 6     |V        |- |V  |nulla
        Example 7     |V        |/ |II |non potest
        Example 8     |MMM      |+ |M  |non potest
        Example 9     |V        |- |X  |non potest
        Large division|MMMCMXCVI|/ |IV |CMXCIX
        END
}

################################################################################
