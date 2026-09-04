#!perl

################################################################################
=comment

Perl Weekly Challenge 389
=========================

TASK #1
-------
*Reorder Notes*

Submitted by: Reinier Maliepaard

You are given an array [composer, notes, permutation], reconstruct the melody by
using each permutation value as the destination position of the corresponding
note. Use no explicit for, foreach, or while loops. Output each result as
COMPOSER => reordered notes.

  ASSUMPTION: Input is valid; the notes array and permutation array have
  identical lengths, and the permutation contains each position from 1 to N
  exactly once.

Example 1

  Input: $melody = ['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]]
  Output: BACH => D F# A B G E C

  Note 1 (C)  moves to position 7.
  Note 2 (D)  moves to position 1.
  Note 3 (E)  moves to position 6.
  Note 4 (F#) moves to position 2.
  Note 5 (G)  moves to position 5.
  Note 6 (A)  moves to position 3.
  Note 7 (B)  moves to position 4.

Example 2

  Input: $melody = ['Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]]
  Output: BEETHOVEN => C G D Ab F#

  Note 1 (C)  stays at position 1.
  Note 2 (D)  moves to position 3.
  Note 3 (F#) moves to position 5.
  Note 4 (G)  moves to position 2.
  Note 5 (Ab) moves to position 4.

Example 3

  Input: $melody = [ 'Brahms', [qw(C Db Eb F G Ab Bb C D)], [9, 3, 7, 1, 8, 5,
                                   2, 6, 4] ]
  Output: BRAHMS => F Bb Db D Ab C Eb G C

Example 4

  Input: $melody = [ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ]
  Output: BRUCKNER => D Bb F G Eb C F#

Example 5

  Input: $melody = ['Berg', [qw(C#)], [1]]
  Output: BERG => C#

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
2. The name of a composer, a string of space-separated musical notes, and a list
   of unsigned integers are entered on the command-line.

Assumption
----------
Valid notes are as follows:

   Ab A A# Bb B B# Cb C C# Db D D# Eb E E# Fb F F# Gb G G#

Double sharps and double flats are not supported, nor is the natural sign.

=cut
#===============================================================================

use v5.38.2;        # Enables strictures
use warnings;
use Const::Fast;
use List::MoreUtils qw( zip );
use Regexp::Common  qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <name> <notes> [<perms> ...]
  perl $0

    <name>           The name of a composer
    <notes>          A string of n space-separated musical notes
    [<perms> ...]    The permutation list (an ordering of the numbers 1 to n)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 389, Task #1: Reorder Notes (Perl)\n\n";
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
    elsif ($argc >= 3)
    {
        my ($name, $notes, $perms) = parse_input( @ARGV );

        printf "Input:  \$melody = ['%s', [qw(%s)], [%s]]\n",
                $name, join( ' ', @$notes ), join ', ', @$perms;

        my $reorder = reorder_notes( $name, $notes, $perms );

        print "Output: $reorder\n";
    }
    else
    {
        error( "Expected 0 or 3+ arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reorder_notes
#-------------------------------------------------------------------------------
{
    my ($name, $notes, $perms) = @_;

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # As required, this solution uses no explicit for, foreach, or while loops
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    my $reorder   = uc $name . ' => ';
    my %perm2note = zip @$perms, @$notes;
       $reorder  .= join ' ', @perm2note{ 1 .. scalar @$notes };    # Hash slice

    return $reorder;
}

#-------------------------------------------------------------------------------
sub parse_input
#-------------------------------------------------------------------------------
{
    my ($name, $notes_str, @perms) = @_;

    length $name > 0 or error( 'Empty composer name' );

    my @notes;

    for my $note_str (split / \s+ /x, $notes_str)
    {
        $note_str =~ / ^ [A-G] [b#]? $ /x
            or error( qq["$note_str" is not a valid note] );

        push @notes, $note_str;
    }

    scalar @notes > 0 or error( 'No notes supplied' );

    my $i = 1;

    for my $perm (sort { $a <=> $b } @perms)
    {
        $perm =~ / ^ $RE{num}{int} $ /x
                 or error( qq["$perm" is not a valid integer] );

        0 <= $perm <= scalar @notes
            or error( "Permutation element $perm is out of range" );

        $perm = $i++ or error( 'Invalid permutation' );
    }

    return ($name, \@notes, \@perms);
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

        my  ($test_name, $composer, $notes_str, $perms_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $composer, $notes_str, $perms_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my  @perms   = split / \s+ /x, $perms_str;
        my ($name, $notes, $perms) = parse_input( $composer, $notes_str, @perms );
        my  $reorder = reorder_notes( $name, $notes, $perms );

        is  $reorder, $expected, $test_name;
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
Example 1|Bach|C D E F# G A B|7 1 6 2 5 3 4|BACH => D F# A B G E C
Example 2|Beethoven|C D F# G Ab|1 3 5 2 4|BEETHOVEN => C G D Ab F#
Example 3|Brahms|C Db Eb F G Ab Bb C D|9 3 7 1 8 5 2 6 4|                      \
          BRAHMS => F Bb Db D Ab C Eb G C
Example 4|Bruckner|G F# Bb C D Eb F|4 7 2 6 1 5 3|BRUCKNER => D Bb F G Eb C F#
Example 5|Berg|C#|1|BERG => C#
