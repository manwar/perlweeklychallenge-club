use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 388
=========================

TASK #1
-------
*Dyck Words*

Submitted by: Roger Bell_West

A Dyck Word of order $n is a string of length 2x$n consisting of $n ‘U’ (Up)
characters and $n ‘D’ (Down) characters such that no initial prefix of the
string contains more ‘D’s than ‘U’s.

Write a script to return a list of all valid Dyck words of length 2x$n, sorted
in lexicographical (alphabetical) order.

Example 1

  Input: $n = 1
  Output: ("UD")

Example 2

  Input: $n = 2
  Output: ("UDUD","UUDD")

Example 3

  Input: $n = 3
  Output: ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")

Example 4

  Input: $n = 0
  Output: ("")

Example 5

  Input: $n = 4
  Output: ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
           "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
           "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")

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
2. An unsigned integer n (the Dyck word order) is entered on the command-line.
3. If the constant SHOW-COUNT is set to True, the output is augmented with a
   count of the total Dyck words of order n.

Algorithm
---------
1. Strings of characters 'D' and 'U' only are generated progressively such that,
   for each string, no initial prefix contains more 'D's than 'U's. This contin-
   ues until the strings are of length 2n.
2. The strings generated in step 1 are filtered, leaving only those in which the
   number of 'D's is equal to the number of 'U's. These are the valid Dyck words
   of order n.

Word Counts
-----------
For n = 0 to 10, the total number of valid Dyck words of order n is as follows:
    0, 1, 2, 5, 14, 42, 132, 429, 1430, 4862, 16796
For n > 0, these are the Catalan numbers [1].

References
----------
[1] "A000108 Catalan numbers...", _OEIS_, https://oeis.org/A000108
[2] "Dyck language", _Wikipedia_, https://en.wikipedia.org/wiki/Dyck_language

=end comment
#===============================================================================

use Test;

subset DyckStr of Str where / ^ <[ D U ]>* $ /;

my Bool constant SHOW-COUNT = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 388, Task #1: Dyck Words (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $n               #= Dyck word order (unsigned integer)
)
#===============================================================================
{
    "Input:  \$n = $n".put;

    my DyckStr @dyck-words = find-dyck-words( $n );

    "Output: (%s)\n".printf: @dyck-words.map( { qq["$_"] } ).join: ', ';

    "\nCount: %d\n".printf: @dyck-words.elems if SHOW-COUNT;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-dyck-words( UInt:D $n --> List:D[DyckStr:D] )
#-------------------------------------------------------------------------------
{
    my DyckStr @dyck-words;

    # (1) Strings of characters 'D' and 'U' only are generated progressively
    #     such that, for each string, no initial prefix contains more 'D's than
    #     'U's. This continues until the strings are of length 2n.

    my DyckStr @odd-words = 'U';

    for 1 .. $n -> UInt $i
    {
        @dyck-words = ();
        @dyck-words.push: $_ ~ 'D', $_ ~ 'U' for @odd-words;

        last if $i == $n;

        @odd-words = ();

        for @dyck-words -> DyckStr $word
        {
            push @odd-words, $word ~ 'D' if $i > $word.comb( 'D' ).elems;
            push @odd-words, $word ~ 'U';
        }
    }

    # (2) The strings generated in step (1) are filtered, leaving only those in
    #     which the number of 'D's is equal to the number of 'U's. These are the
    #     valid Dyck words of order n.

    @dyck-words = @dyck-words.grep: { .comb( 'D' ).elems == $n };

    return @dyck-words;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $exp-str) = $line.split: '|';

        for     $test-name, $n, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my DyckStr @dyck-words = find-dyck-words( $n.Int );
        my DyckStr @expected   = $exp-str.split: / \s+ /, :skip-empty;

        is-deeply  @dyck-words, @expected, $test-name;
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
    my Str $data = q:to/END/;
        Example 1|1|UD
        Example 2|2|UDUD     UUDD
        Example 3|3|UDUDUD   UDUUDD   UUDDUD   UUDUDD   UUUDDD
        Example 4|0|
        Example 5|4|UDUDUDUD UDUDUUDD UDUUDDUD UDUUDUDD UDUUUDDD               \
                    UUDDUDUD UUDDUUDD UUDUDDUD UUDUDUDD UUDUUDDD               \
                    UUUDDDUD UUUDDUDD UUUDUDDD UUUUDDDD
        END

    return S:g/ \s+ \\ \n \s* / / given $data;
}

################################################################################
