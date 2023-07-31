#!perl

################################################################################
=comment

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

Notes
-----
1. Roman numerals in lower case will be converted to upper case.
2. A non-standard form such as "IM" is (incorrectly?) interpreted as 1001, not
   999 as might be expected.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Switch::Plain;
use Test::More;
use Text::Roman qw( int2roman isroman roman2int );

const my $MAX_ROM_NUM  =>  3999;
const my @OPERATORS    =>  qw( + - * / ** );
const my $ROM_NUM_ZERO => 'nulla';               # Latin "no", Italian "nothing"
const my $UNDEFINED    => 'non potest';          # Latin "can not"
const my $USAGE        =>
"Usage:
  perl $0 <operand1> <operator> <operand2>
  perl $0

    <operand1>    Left operand: number in Roman numerals
    <operator>    Arithmetic operator: + - * / **
    <operand2>    Right operand: number in Roman numerals\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 227, Task #2: Roman Maths (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 3)
    {
        my ($operand1, $operator, $operand2) = parse_command_line();

        print "Input:  $operand1 $operator $operand2\n";

        my $result = calculate( $operand1, $operator, $operand2 );

        print "Output: $result\n";
    }
    else
    {
        error( "Expected 0 or 3 command-line arguments, found $args" );
    }
}

#-------------------------------------------------------------------------------
sub calculate
#-------------------------------------------------------------------------------
{
    my ($operand1, $operator, $operand2) = @_;
    my  $result;
    my  $left_op  = roman2int( $operand1 );
    my  $right_op = roman2int( $operand2 );

    sswitch ($operator)
    {
        case '+':  { $result =            add( $left_op, $right_op ); }
        case '-':  { $result =       subtract( $left_op, $right_op ); }
        case '*':  { $result =       multiply( $left_op, $right_op ); }
        case '/':  { $result =         divide( $left_op, $right_op ); }
        case '**': { $result = raise_to_power( $left_op, $right_op ); }
        default:   {  die qq[Invalid operator "$operator"];           }
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub add
#-------------------------------------------------------------------------------
{
    my ($left_op, $right_op) = @_;

    my  $sum = $left_op + $right_op;

    return $sum > $MAX_ROM_NUM ? $UNDEFINED : int2roman( $sum );
}

#-------------------------------------------------------------------------------
sub subtract
#-------------------------------------------------------------------------------
{
    my ($left_op, $right_op) = @_;

    my  $difference = $left_op - $right_op;

    return $difference == 0 ? $ROM_NUM_ZERO :
           $difference <  0 ? $UNDEFINED    : int2roman( $difference );
}

#-------------------------------------------------------------------------------
sub multiply
#-------------------------------------------------------------------------------
{
    my ($left_op, $right_op) = @_;

    my  $product = $left_op * $right_op;

    return $product > $MAX_ROM_NUM ? $UNDEFINED : int2roman( $product );
}

#-------------------------------------------------------------------------------
sub divide
#-------------------------------------------------------------------------------
{
    my ($left_op, $right_op) = @_;

    return ($left_op % $right_op) ? $UNDEFINED :
                                    int2roman( int( $left_op / $right_op ) );
}

#-------------------------------------------------------------------------------
sub raise_to_power
#-------------------------------------------------------------------------------
{
    my ($left_op, $right_op) = @_;

    my  $power = $left_op ** $right_op;

    return $power > $MAX_ROM_NUM ? $UNDEFINED : int2roman( $power );
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($operand1, $operator, $operand2) = @ARGV;

    $operand1 = uc $operand1;
    $operand2 = uc $operand2;

    isroman( $operand1 )
              or error( qq["$operand1" is not a valid Roman numeral] );

    my $valid_op = 0;

    for my $op (@OPERATORS)
    {
        if ($operator eq $op)
        {
            $valid_op = 1;
            last;
        }
    }

    $valid_op or error( qq["$operator" is not a valid arithmetic operator] );

    isroman( $operand2 )
              or error( qq["$operand2" is not a valid Roman numeral] );

    return ($operand1, $operator, $operand2);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $op1, $opr, $op2, $expected) = split / \| /x, $line;

        for ($test_name, $op1, $opr, $op2, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $result = calculate( $op1, $opr, $op2 );

        is $result, $expected, $test_name;
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
