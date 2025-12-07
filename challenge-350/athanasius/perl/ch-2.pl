#!perl

################################################################################
=comment

Perl Weekly Challenge 350
=========================

TASK #2
-------
*Shuffle Pairs*

Submitted by: E. Choroba

If two integers A <= B have the same digits but in different orders, we say that
they belong to the same _shuffle pair_ if and only if there is an integer k such
that B = A * k where k is called the _witness_ of the pair.

For example, 1359 and 9513 belong to the same shuffle pair, because 1359 * 7 =
9513.

Interestingly, some integers belong to several different shuffle pairs. For
example, 123876 forms one shuffle pair with 371628, and another with 867132, as
123876 * 3 = 371628, and 123876 * 7 = 867132.

Write a function that for a given $from, $to, and $count returns the number of
integers $i in the range $from <= $i <= $to that belong to at least $count
different shuffle pairs.

PS: Inspired by a conversation between Mark Dominus and Simon Tatham at
Mastodon.

Example 1

  Input: $from = 1, $to = 1000, $count = 1
  Output: 0

  There are no shuffle pairs with elements less than 1000.

Example 2

  Input: $from = 1500, $to = 2500, $count = 1
  Output: 3

  There are 3 integers between 1500 and 2500 that belong to shuffle pairs.

  1782, the other element is 7128 (witness 4)
  2178, the other element is 8712 (witness 4)
  2475, the other element is 7425 (witness 3)

Example 3

  Input: $from = 1_000_000, $to = 1_500_000, $count = 5
  Output: 2

  There are 2 integers in the given range that belong to 5 different shuffle
  pairs.

  1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
  1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142

  The witnesses are 2, 3, 4, 5, and 6 for both the integers.

Example 4

  Input: $from = 13_427_000, $to = 14_100_000, $count = 2
  Output: 11

  6 integers in the given range belong to 3 different shuffle pairs, 5 integers
  belong to 2 different ones.

Example 5

  Input: $from = 1030, $to = 1130, $count = 1
  Output: 2

  There are 2 integers between 1020 and 1120 that belong to at least one shuffle
  pair:
  1035, the other element is 3105 (witness k = 3)
  1089, the other element is 9801 (witness k = 9)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Input integers are in decimal form.
2. $from >= 0, $to >= $from, and $count > 0.
3. Permutations with leading zeros are excluded.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Three integers ($from, $to, and $count) are entered on the command-line.
3. If the constant TIMER is set to a true value, the total time taken to run
   the script is displayed at the conclusion of the run.
4. If the constant VERBOSE is set to a true value, each set of shuffle pairs
   meeting the given criteria is displayed as it is found. In addition, for each
   test in the test suite, the criteria are displayed at the outset of the test,
   and the result is displayed at its conclusion.

OEIS
----
The sequence:
  "A245680  Numbers x whose digits can be permuted to produce a multiple of x."
comprises the A values only for all < A, B > shuffle pairs where A < B.

The comments for A245680 include the following observation:
  "Every element of the sequence is divisible by 3."

Performance
-----------
Running on Strawberry Perl 5.38.2 under Windows 11, the test suite completes in
about 42 seconds.

Sample Run
----------
With TIMER and VERBOSE set:

 0:27 >perl ch-2.pl

Challenge 350, Task #2: Shuffle Pairs (Perl)

Running the test suite

$from = 1 $to = 1000, $count = 1:
Output: 0
ok 1 - Example 1

$from = 1500 $to = 2500, $count = 1:
  1782: 7128
  2178: 8712
  2475: 7425
Output: 3
ok 2 - Example 2

$from = 1000000 $to = 1500000, $count = 5:
  1428570: 2857140, 4285710, 5714280, 7142850, 8571420
  1429857: 2859714, 4289571, 5719428, 7149285, 8579142
Output: 2
ok 3 - Example 3

$from = 13427000 $to = 14100000, $count = 2:
  13428567: 26857134, 53714268, 67142835
  13428657: 26857314, 53714628, 67143285
  13567842: 27135684, 54271368
  13568427: 27136854, 67842135
  13874526: 41623578, 83247156
  13875246: 41625738, 83251476
  14002857: 28005714, 42008571, 70014285
  14025897: 28051794, 70129485
  14028570: 28057140, 42085710, 70142850
  14028597: 28057194, 42085791, 70142985
  14029857: 28059714, 42089571, 70149285
Output: 11
ok 4 - Example 4

$from = 1030 $to = 1130, $count = 1:
  1035: 3105
  1089: 9801
Output: 2
ok 5 - Example 5
1..5

41.961471 seconds

 0:28 >

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

use constant TIMER   => 1;
use constant VERBOSE => 1;

use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

const my $USAGE => <<END;
Usage:
  perl $0 <from> <to> <count>
  perl $0

    <from>     Start of range
    <to>       End   of range
    <count>    Minimum different shuffle pairs
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 350, Task #2: Shuffle Pairs (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $t0   = [gettimeofday]                     if TIMER;
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 3)
    {
        my ($from, $to, $count) = validate_input( @ARGV );

        print "Input:  \$from = $from, \$to = $to, \$count = $count\n";

        my $ints = count_ints( $from, $to, $count );

        print "Output: $ints\n";
    }
    else
    {
        error( "Expected 0 or 3 command-line arguments, found $argc" );
    }

    printf "\n%.2f seconds\n", tv_interval( $t0 ) if TIMER;
}

#-------------------------------------------------------------------------------
sub validate_input
#-------------------------------------------------------------------------------
{
    my  ($from, $to, $count) = @_;

    for ($from, $to, $count)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        $_ >= 0                or error( "$_ is negative");
    }

    $to    >= $from            or error( '$to cannot be less than $from' );
    $count >  0                or error( '$count cannot be zero');

    return @_;
}

#-------------------------------------------------------------------------------
sub count_ints
#-------------------------------------------------------------------------------
{
    my ($from, $to, $count) = validate_input( @_ );
    my  $ints  = 0;
    my  $start = $from + (($from % 3 == 0) ? 0 : 3 - ($from % 3));

    for (my $i = $start; $i <= $to; $i += 3)
    {
        my $pairs = find_shuffle_pairs( $i );

        if (scalar @$pairs >= $count)
        {
            ++$ints;
            printf "  %d: %s\n", $i, join ', ', @$pairs if VERBOSE;
        }
    }

    return $ints;
}

#-------------------------------------------------------------------------------
sub find_shuffle_pairs
#-------------------------------------------------------------------------------
{
    my ($int) = @_;
    my  @pairs;

    for my $i (2 .. 9)
    {
        if ($int % $i == 0)
        {
            my $m = $int / $i;

            push @pairs, $m if are_permutations( $int, $m );
        }

        my $n = $int * $i;

        push @pairs, $n     if are_permutations( $int, $n );
    }

    return \@pairs;
}

#-------------------------------------------------------------------------------
sub are_permutations
#-------------------------------------------------------------------------------
{
    my ($lhs, $rhs) = @_;
    my  $lhs_str    = join '', sort { $a <=> $b } split //, $lhs;
    my  $rhs_str    = join '', sort { $a <=> $b } split //, $rhs;

    return $lhs_str eq $rhs_str;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $from, $to, $count, $expected) = split / \| /x, $line;

        for ($test_name, $from, $to, $count, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        print "\n\$from = $from \$to = $to, \$count = $count:\n" if VERBOSE;

        my $ints = count_ints( $from, $to, $count );

        print "Output: $ints\n"                                  if VERBOSE;

        is $ints, $expected, $test_name;
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
Example 1|       1|    1000|1| 0
Example 2|    1500|    2500|1| 3
Example 3| 1000000| 1500000|5| 2
Example 4|13427000|14100000|2|11
Example 5|    1030|    1130|1| 2
