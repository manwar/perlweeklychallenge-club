use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 099
=========================

Task #1
-------
*Pattern Match*

Submitted by: Mohammad S Anwar

You are given a string $S and a pattern $P.

Write a script to check if given pattern validate the entire string. Print 1 if
pass otherwise 0.

The patterns can also have the following characters:

? - Match any single character.
* - Match any sequence of characters.

Example 1:

 Input: $S = "abcde" $P = "a*e"
 Output: 1

Example 2:

 Input: $S = "abcde" $P = "a*d"
 Output: 0

Example 3:

 Input: $S = "abcde" $P = "?b*d"
 Output: 0

Example 4:

 Input: $S = "abcde" $P = "a*c?e"
 Output: 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------

The special pattern character "*" is specified to "Match any sequence of char-
acters". Does this include a zero-length sequence? In the absence of further
information the answer is assumed to be Yes.

The Task description does not specify whether the empty string is a legal
pattern. For the sake of convenience, the empty string is here disallowed as a
pattern (but it is allowed for $S, in which case the output will always be 0).

Note: On the Windows command line (i.e., using cmd.exe), it is not (always)
possible to specify a single "*" as the pattern. See the Perl Monks thread:

    "[Raku] Asterisk on DOS command line"
     [https://www.perlmonks.com/index.pl?node_id=11128174]

(Raku's treatment of * on the DOS command-line apparently depends on Rakudo's
build environment.)

Solution
--------

Advantage is taken of Raku's built-in regular expression functionality: $P is
transformed into a regex pattern by substituting "." for "?" and ".*" for "*",
respectively.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 099, Task #1: Pattern Match (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $S,                                   #= A string
    Str:D $P is copy where { $P.chars > 0 }     #= A pattern (non-empty string)
)
#==============================================================================
{
    qq[Input:  \$S = "$S" \$P = "$P"].put;

    $P ~~ s :g / \? /./;
    $P ~~ s :g / \* /.*/;

    "Output: %d\n".printf: $S ~~ rx/ ^ <$P> $ / ?? 1 !! 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
