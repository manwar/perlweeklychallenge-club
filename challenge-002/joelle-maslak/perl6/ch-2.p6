#!/usr/bin/env perl6
use v6;

# Challenge:
#   Write a script that can convert integers to and from a base35
#   representation, using the characters 0-9 and A-Y. Dave Jacoby came
#   up with nice description about base35, in case you needed some
#   background.
#
# Assumptions:
#   * This should be case-insensitive on input
#   * This should use only upper case on output
#   * Negative numbers should be accepted.
#   * Only integers are handled
#
#   Example input/output:
#     perl6 2.pl6 encode 10    --> A
#     perl6 2.pl6 encode 100   --> 2U
#     perl6 2.pl6 encode -10   --> -A
#     perl6 2.pl6 decode A     --> 10
#     perl6 2.pl6 decode 2U    --> 100
#     perl6 2.pl6 decode -A    --> -10
#
#
# Implementation:
#   This is essentially two programs, one to convert decimal integer to
#   a base 35 integer, the other to do the reverse.
#
#   Perl 6 allows multi-dispatch, including of the MAIN routine.  This
#   means you can define two (or more) MAIN routines, and the one that
#   gets executed will be the one where the command line parameters
#   satisfy all requirements of the parameter definition.  For these two
#   MAINs, we have a "where" clause on the first (anonymous) parameter.
#   If neither where condition matches, the program will give an error.
#
#   ENCODE:
#
#   For the encode version, the second parameter is an Int:D - that is,
#   a defined integer.  Perl 6 automatically converts a base 10 integer
#   on the command line to an Int with this style of parameter
#   definition, if it can be converted to an Int.  If it can't be (for
#   instance, it contains invalid chracters), then this multi sub won't
#   match the parameters and eventually (assuming no others match) will
#   throw an error.
#
#   The actual encoding routine is simple in Perl 6 - it has a built-in
#   base conversion function. Part of knowing the language is knowing
#   about built-ins.
#
#   DECODE:
#
#   This is similar, although the input string is checked with a regex
#   that ensures that the string, matched case insensitively (:i does
#   that) contains an optional - followed by 1 or more base 36
#   characters.
#
#   The actual decoding is using Str.parse-base, which returns a number
#   by parsing the string.
#
#   USAGE:
#
#   I've overriden the default usage method to provide some help to the
#   user. This is 

multi sub MAIN(
    Str:D $ where 'encode',
    Int:D $input
) {
    say $input.base(35);

}

multi sub MAIN(
    Str:D $ where 'decode',
    Str:D $input where $input ~~ m:i/^ '-'? <[0..9 A..Y]>+ $/
) {
    say $input.parse-base(35);
}

sub USAGE() {
    $*ERR.say("Usage: ");
    $*ERR.say("  {$*PROGRAM-NAME} <op> <num>");
    $*ERR.say("    <op>  'encode' to convert to Base35 or 'decode' to convert from Base35");
    $*ERR.say("    <num> A number in the proper format for the operation");
    $*ERR.say("");
    exit 1;
}


