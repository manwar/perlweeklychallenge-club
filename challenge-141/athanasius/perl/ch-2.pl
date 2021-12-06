#!perl

###############################################################################
=comment

Perl Weekly Challenge 141
=========================

TASK #2
-------
*Like Numbers*

Submitted by: Mohammad S Anwar

You are given positive integers, $m and $n.

Write a script to find total count of integers created using the digits of $m
which is also divisible by $n.

Repeating of digits are not allowed. Order/Sequence of digits can't be altered.
You are only allowed to use (n-1) digits at the most. For example, 432 is not
acceptable integer created using the digits of 1234. Also for 1234, you can
only have integers having no more than three digits.

Example 1:

 Input: $m = 1234, $n = 2
 Output: 9

 Possible integers created using the digits of 1234 are:
 1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134 and 234.

 There are 9 integers divisible by 2 such as:
 2, 4, 12, 14, 24, 34, 124, 134 and 234.

Example 2:

 Input: $m = 768, $n = 4
 Output: 3

 Possible integers created using the digits of 768 are:
 7, 6, 8, 76, 78 and 68.

 There are 3 integers divisible by 4 such as:
 8, 76 and 68.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
- "You are only allowed to use (n-1) digits at the most." From the examples, I
  assume the "n" here is unrelated to $n, and is a shorthand for the following:
  If $m has n digits, then each created integer may contain between 1 and n-1
  digits.
- "Repeating of digits are not allowed." I assume this means that a digit which
  occurs once in $m cannot occur twice in a created integer. But I assume that
  repeated digits are allowed within $m, and that these repeated digits may
  also occur in created integers (provided they occur in the correct order).
- I assume that the desired output is a count of *unique* solutions.

Configuration
-------------
- If the digit 0 occurs in $m, then the number zero will be a possible created
  integer; and since 0 is evenly divisible by any (non-zero) integer, 0 will
  then always appear in the solution set. It is not clear from the Task Des-
  cription whether this is the desired result; so the constant $ALLOW_0 is pro-
  vided. When it is set to a true value (the default), 0 may appear in the
  solution set; when it is set to a false value, the number 0 will be excluded
  from the solution set.
- When the constant $VERBOSE is set to a true value (the default), the output
  will be followed by a list of possible integers and a list of the integers in
  the solution set, as shown in the Task Description.

Algorithm
---------
Determining whether a created integer is evenly divisible by $n is trivial. But
the construction of possible integers which precedes this step is more inter-
esting:

    [Array] pool := the empty string
    FOR each digit d in $m (most to least significant digit)
        FOR each entry p in pool (as it is populated on *entering* this loop)
            concatenate p with d and store the result ("pd") in pool
        ENDFOR
    ENDFOR
    Remove the empty string and the string representing $m from pool
    Remove any strings beginning with an initial '0'
    Optionally restore the number zero itself
    Remove duplicates from pool
    Convert the strings in pool to integers
    Sort the integers in pool in ascending numerical order

The above algorithm could also be performed in reverse:

    FOR each digit d in $m (least to most significant digit)
        FOR each entry p in pool (as it is populated on *entering* this loop)
            concatenate d with p and store the result ("dp") in pool
        ENDFOR
    ENDFOR

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $ALLOW_0 => 1;
const my $USAGE   =>
"Usage:
  perl $0 <m> <n>

    <m>    Positive integer: source of digits
    <n>    Positive integer: divisor\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 141, Task #2: Like Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($m, $n) = parse_command_line();

    print "Input:  \$m = $m, \$n = $n\n";

    my @ints = find_all_integers( $m );
    my @like;

    for my $i (@ints)
    {
        push @like, $i if $i % $n == 0;
    }

    printf "Output: %d\n", scalar @like;

    explain( $m, $n, \@ints, \@like ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub find_all_integers
#------------------------------------------------------------------------------
{
    my ($m)   = @_;
    my  @pool = '';

    for my $digit (split //, $m)
    {
        push @pool, $pool[ $_ ] . $digit for 0 .. $#pool;
    }

    shift @pool;        # Remove the empty string
    pop   @pool;        # Remove $m

    @pool = grep { !/ ^ 0 /x } @pool;

    push @pool, 0 if $ALLOW_0 && $m =~ / 0 /x;        # Optionally restore zero

    my %uniq;
     ++$uniq{ $_ } for @pool;

    return sort { $a <=> $b } keys %uniq;
}

#------------------------------------------------------------------------------
sub explain
#------------------------------------------------------------------------------
{
    my ($m, $n, $ints, $like) = @_;
    my  $possibles = scalar @$ints;
    my  $solutions = scalar @$like;

    printf "\n%d integer%s can be created using the digits of %d",
            $possibles, ($possibles == 1 ? ''   : 's'  ), $m;

    print +($possibles == 0) ? "\n" : ":\n" . join( ', ', @$ints ) . "\n";

    printf "\nof which %d %s evenly divisible by %d",
            $solutions, ($solutions == 1 ? 'is' : 'are'), $n;

    print +($solutions == 0) ? "\n" : ":\n" . join( ', ', @$like ) . "\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command line arguments, found $args" );

    my ($m, $n) = @ARGV;

    for my $i ($m, $n)
    {
        $i =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$i" is not a valid integer] );

        $i > 0    or error( qq["$i" is not positive] );
    }

    return ($m, $n);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
