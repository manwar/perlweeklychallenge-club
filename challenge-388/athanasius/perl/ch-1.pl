#!perl

################################################################################
=comment

Perl Weekly Challenge 388
=========================

TASK #1
-------
*Dyck Words*

Submitted by: Roger Bell_West

A Dyck Word of order $n is a string of length 2x$n consisting of $n 'U' (Up)
characters and $n 'D' (Down) characters such that no initial prefix of the
string contains more 'D's than 'U's.

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. An unsigned integer n (the Dyck word order) is entered on the command-line.
3. If the constant $SHOW_COUNT is set to a true value, the output is augmented
   with a count of the total Dyck words of order n.

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

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $SHOW_COUNT => 1;
const my $USAGE      => <<END;
Usage:
  perl $0 <n>
  perl $0

    <n>    Dyck word order (unsigned integer)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 388, Task #1: Dyck Words (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my ($n) = @ARGV;
            $n  =~ / ^ $RE{num}{int} $ /x
                     or error( qq["$n" is not a valid integer] );
            $n  >= 0 or error( '$n is negative' );

        print  "Input:  \$n = $n\n";

        my $dyck_words = find_dyck_words( $n );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$dyck_words;

        printf "\nCount: %d\n", scalar @$dyck_words if $SHOW_COUNT;
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_dyck_words
#-------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  @dyck_words;

    # (1) Strings of characters 'D' and 'U' only are generated progressively
    #     such that, for each string, no initial prefix contains more 'D's than
    #     'U's. This continues until the strings are of length 2n.

    my  @odd_words = 'U';

    for my $i (1 .. $n)
    {
        @dyck_words = ();

        push @dyck_words, $_ . 'D', $_ . 'U' for @odd_words;

        last if $i == $n;

        @odd_words = ();

        for my $word (@dyck_words)
        {
            push @odd_words, $word . 'D' if ($word =~ tr/D//) < $i;
            push @odd_words, $word . 'U';
        }
    }

    # (2) The strings generated in step (1) are filtered, leaving only those in
    #     which the number of 'D's is equal to the number of 'U's. These are the
    #     valid Dyck words of order n.

    @dyck_words = grep { tr/D// == $n } @dyck_words;

    return \@dyck_words;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        while ($line =~ / \\ $ /x)
        {
            $line =~ s/ \\ \n //x;
            $line .= <DATA>;
        }

        chomp $line;

        my  ($test_name, $n, $exp_str) = split / \| /x, $line;

        for ($test_name, $n, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $dyck_words = find_dyck_words( $n );
        my @expected   = split / \s+ /x, $exp_str;

        is_deeply $dyck_words, \@expected, $test_name;
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
Example 1|1|UD
Example 2|2|UDUD     UUDD
Example 3|3|UDUDUD   UDUUDD   UUDDUD   UUDUDD   UUUDDD
Example 4|0|
Example 5|4|UDUDUDUD UDUDUUDD UDUUDDUD UDUUDUDD UDUUUDDD                       \
            UUDDUDUD UUDDUUDD UUDUDDUD UUDUDUDD UUDUUDDD                       \
            UUUDDDUD UUUDDUDD UUUDUDDD UUUUDDDD
