use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 387
=========================

TASK #2
-------
*Atoms Count*

Submitted by: Mohammad Sajid Anwar

You are given a chemical formula with elements, numbers, and parentheses.

Write a script to count the total number of each type of atom by expanding all
grouped multipliers. Then, format and return the final inventory as a single
string sorted alphabetically by element name, including the total count only if
it is greater than 1.

Example 1

  Input: $formula = "((N2O)3(H2O)2)2"
  Output: "H8N12O10"

  Step 1: Expand the innermost parentheses
      (N2O)3 => N = 2*3 = 6, O = 1*3 = 3 => N6O3
      (H2O)2 => H = 2*2 = 4, O = 1*2 = 2 => H4O2

  Step 2: Combine inside the outer parentheses
      Formula becomes: (N6O3 H4O2)2
      Sum up identical elements inside: (N6 H4 O5)2

  Step 3: Apply the outer multiplier
      N = 6*2 = 12
      H = 4*2 = 8
      O = 5*2 = 10

  Step 4: Sort alphabetically and format
      Alphabetical order: H, N, O
      Counts: H: 8, N: 12, O: 10

Example 2

  Input: $formula = "Mg3(PO4)2"
 Output: "Mg3O8P2"

  Step 1: Parse ungrouped elements
      Mg3 => Mg = 3

  Step 2: Expand parentheses (PO4)2
      P = 1*2 = 2
      O = 4*2 = 8

  Step 3: Total up counts
      Mg = 3
      P  = 2
      O  = 8

  Step 4: Sort alphabetically and format
      Alphabetical order: Mg, O, P
      Counts: Mg: 3, O: 8, P: 2

Example 3

  Input: $formula = "(((H)2)3)4"
  Output: "H24"

  Step 1: Expand innermost level (H)2
      H = 1*2 = 2 => formula becomes ((H2)3)4

  Step 2: Expand middle level (H2)3
      H = 2*3 = 6 => formula becomes (H6)4

  Step 3: Expand outer level (H6)4
      H = 6*4 = 24

  Step 4: Sort alphabetically and format
      Single element: H: 24

Example 4

  Input: $formula = "NaCl3(O2(S10)2)2Mg"
  Output: "Cl3MgNaO4S40"

  Step 1: Expand innermost parentheses (S10)2
      S = 10*2 = 20 => inner formula becomes => O2S20

  Step 2: Expand outer parentheses (O2S20)2
      O = 2*2  = 4
      S = 20*2 = 40

  Step 3: Combine all parts
      Ungrouped start: Na (Na = 1), Cl3 (Cl = 3)
      Expanded middle: O = 4, S = 40
      Ungrouped end: Mg (Mg = 1)

  Step 4: Sort alphabetically and format
      Alphabetical order: Cl (3), Mg (1), Na (1), O (4), S (40)
      Omit the number 1 for Mg and Na.

Example 5

  Input: $formula = "Z2Y3(X2W)2"
  Output: "W2X4Y3Z2"

  Step 1: Parse ungrouped elements
      Z2 => Z = 2
      Y3 => Y = 3

  Step 2: Expand parentheses (X2W)2
      X = 2*2 = 4
      W = 1*2 = 2

  Step 3: Total up counts
      W = 2, X = 4, Y = 3, Z = 2

  Step 4: Sort alphabetically and format
      Alphabetical order: W (2), X (4), Y (3), Z (2)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A chemical formula is entered on the command-line as a single string.

Assumption
----------
Input formulae are well-formed. The solution does NOT detect malformed formulae.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 387, Task #2: Atoms Count (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $formula    #= A chemical formula (elements, numbers, and parentheses)
)
#===============================================================================
{
    qq[Input:  \$formula = "$formula"].put;

    my Str $atom-count = count-atoms( $formula );

    qq[Output: "$atom-count"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-atoms( Str:D $formula is copy --> Str:D )
#-------------------------------------------------------------------------------
{
    # (1) Replace all single-element multipliers with element duplicates; e.g.,
    #     H2O3 -> HHOOO

    $formula ~~ s :g/ (<[ A .. Z ]> <[ a .. z ]>?) (\d+) / { $0 x $1 } /;

    # (2) Add a multiplier of 1 to all bare-parenthesis groups; e.g.,
    #     (SOO(OH)CCCC)2 -> (SOO(OH)1CCCC)2
    #                               ^

    $formula ~~ s :g/ \) <!before \d > /\)1/;

    # (3) Recursively replace the multiplier of each innermost parenthesis group
    #     with duplicates of the contents of that group; e.g.,
    #     (HHOOOBr)2 -> HHOOOBrHHOOOBr

    Nil while $formula ~~ s :g/ \( (<-[ ( ) ]>+) \) (\d+) / { $0 x $1 } /;

    # (4) Collect all the elements

    my Match @matches = $formula ~~ m :g/ (<[ A .. Z ]> <[ a .. z ]>?) /;

    # (5) Count the elements

    my UInt %element-count{Str};
          ++%element-count{ $_ } for ~«@matches;

    # (6) Construct the element-count string

    my Str $atom-count = '';

    for %element-count.keys.sort -> Str $element
    {
        my UInt $count = %element-count{ $element };
        $atom-count   ~= $element;
        $atom-count   ~= $count if $count > 1;
    }

    return $atom-count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $formula, $expected) = $line.split: '|';

        for     $test-name, $formula, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $atom-count = count-atoms( $formula );

        is $atom-count, $expected, $test-name;
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
        Example 1  |((N2O)3(H2O)2)2   |H8N12O10
        Example 2  |Mg3(PO4)2         |Mg3O8P2
        Example 3  |(((H)2)3)4        |H24
        Example 4  |NaCl3(O2(S10)2)2Mg|Cl3MgNaO4S40
        Example 5  |Z2Y3(X2W)2        |W2X4Y3Z2
        Bare parens|(SO2(OH)C4)2      |C8H2O6S2
        END
}

################################################################################
