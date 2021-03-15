#!perl

###############################################################################
=comment

Perl Weekly Challenge 099
=========================

Task #2
-------
*Unique Subsequence*

Submitted by: Mohammad S Anwar

You are given two strings $S and $T.

Write a script to find out count of different unique subsequences matching $T
without changing the position of characters.

*UPDATE: 2021-02-08 09:00AM (UK TIME) suggested by Jonas Berlin, missing entry
[5].*

Example 1:

 Input: $S = "littleit', $T = 'lit'
 Output: 5

     1: [lit] tleit
     2: [li] t [t] leit
     3: [li] ttlei [t]
     4: litt [l] e [it]
     5: [l] ittle [it]

Example 2:

 Input: $S = "london', $T = 'lon'
 Output: 3

     1: [lon] don
     2: [lo] ndo [n]
     3: [l] ond [on]

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm: Recursive search. The subroutine fine_subseqs() searches $S for the
first character in $T, and then recursively searches the remainder of $S for
the remainder of $T. The recursion ends when either $S or $T is exhausted. (In
the first case, no match was found; in the second case, a match has been found
and is recorded in the @subseqs array.)

Note: If $VERBOSE is set to True, details of all the different subsequences
found are displayed after the Output, as in the Examples. This is done using
the subroutine partition(), which inserts square brackets around those charac-
ters in $S which form a given subsequence.

=cut
#==============================================================================

use strict;
use warnings;
use feature qw( state );
use Const::Fast;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <S> <T>

    <S>    Non-empty string to be searched
    <T>    Non-empty substring to search for in \$S\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 099, Task #2: Unique Subsequence (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($S, $T) = parse_command_line();

    print qq[Input:  \$S = "$S", \$T = "$T"\n];

    my @subseqs;
    my $subseqs = 0;

    if (length $T <= length $S)  # No match is possible if $T is longer than $S
    {
        find_subseqs( $S, 0, $T, \@subseqs );
        $subseqs = scalar @subseqs;
    }

    print "Output: $subseqs\n";

    if ($VERBOSE && $subseqs > 0)
    {
        my $count = 0;

        print  "\n";
        printf "    %d: %s\n", ++$count, partition( $S, $_ ) for @subseqs;
    }
}

#------------------------------------------------------------------------------
sub find_subseqs                                         # Recursive subroutine
#------------------------------------------------------------------------------
{
    state $seq = [];

    my ($s, $i, $t, $subseqs) = @_;

    # (1) Separate the search substring into $t0, its first character, and
    #     $t_rem, the remaining characters (if any)

    my ($t_0, $t_rem) = $t =~ / ^ (.) (.*) $ /x;

    # (2) Beginning with the character at index $i, check each remaining
    #     character in $s as a possible match for $t0: if it matches, add the
    #     character's index ($j) to the array @$seq and recursively search the
    #     remainder of $s for the substring $t_rem

    for my $j ($i .. length($s) - 1)
    {
        if ($t_0 eq substr $s, $j, 1)
        {
            push @$seq, $j;                 # Add index $j to the sequence

            if (length $t_rem == 0)
            {
                push @$subseqs, [ @$seq ];  # Copy the sequence and record it
            }
            else
            {
                find_subseqs( $s, $j + 1, $t_rem, $subseqs );  # Recursive call
            }

            pop @$seq;                      # Remove index $j from the sequence
        }
    }
}

#------------------------------------------------------------------------------
sub partition
#------------------------------------------------------------------------------
{
    my ($S, $seq)  = @_;
    my  @partition = split //, $S;

    # (1) Add square brackets around each character in the subsequence

    for my $i (@$seq)
    {
        $partition[ $i ] = ' [' . $partition[ $i ] . '] ';
    }

    # (2) Remove initial and trailing spaces, and brackets and spaces internal
    #     to a sequence of contiguous characters. E.g., " [l]  [i]  [t] tleit"
    #     becomes  "[lit] tleit"

    my $partition =  join '', @partition;
       $partition =~ s{ \] \s{2} \[ }{}gx;  # Remove internal brackets & spaces
       $partition =~ s{  ^ \s       }{}x;   # Remove initial  space
       $partition =~ s{    \s  $    }{}x;   # Remove trailing space

    return $partition;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command-line arguments, found $args" );

    my ($S, $T) = @ARGV;

    length $S > 0 or error( '$S is empty' );
    length $T > 0 or error( '$T is empty' );

    return ($S, $T);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
