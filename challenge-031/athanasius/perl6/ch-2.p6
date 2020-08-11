use v6;

################################################################################
=begin comment

Perl Weekly Challenge 031
=========================

Task #2
-------
Create a script to demonstrate creating *dynamic variable name*, assign a value
to the variable and finally print the variable. The *variable name* would be
passed as command line argument.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use MONKEY-SEE-NO-EVAL;

my Real constant $VALUE = 42;

BEGIN say '';

#===============================================================================
sub MAIN(Str:D $variable-name)
#===============================================================================
{
    # Declare the variable and assign a value to it

    my Str $expression = "my \$$variable-name = $VALUE;";

    # Print the variable

    $expression ~= " qq[\\\$$variable-name = \$$variable-name].say;";

    # Declaration, assignment, and printing must be EVALuated together to avoid
    # a "Variable ... is not declared" error in the say statement

    EVAL $expression;
}

################################################################################
