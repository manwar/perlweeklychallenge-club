use v6d;

################################################################################
=begin comment

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
2. The name of a composer, a string of space-separated musical notes, and a list
   of unsigned integers are entered on the command-line.

Assumption
----------
Valid notes are as follows:

   Ab A A# Bb B B# Cb C C# Db D D# Eb E E# Fb F F# Gb G G#

Double sharps and double flats are not supported, nor is the natural sign.

=end comment
#===============================================================================

use Test;

subset Note   of Str  where / ^ <[ A .. G ]> <[ b # ]>? $ /;
subset Melody of List where (Str, Array[Note], Array[UInt]);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 389, Task #1: Reorder Notes (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $name,         #= The name of a composer
    Str:D $notes,        #= A string of n space-separated musical notes

    #| The permutation list (an ordering of the numbers 1 to n)

    *@perms where { .all ~~ UInt:D && .min == 1 }
)
#===============================================================================
{
    my Melody $melody = parse-input( $name, $notes, @perms );

    "Input:  \$melody = ['%s', [qw(%s)], [%s]]\n".printf:
        $melody[0], $melody[1].join( ' ' ), $melody[2].join: ', ';

    my Str $reorder = reorder-notes( $melody );

    "Output: $reorder".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reorder-notes( Melody:D $melody --> Str:D )
#-------------------------------------------------------------------------------
{
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # As required, this solution uses no explicit for, foreach, or while loops
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    my Str $reorder         =  $melody[0].uc ~ ' => ';
    my Str %perm2note{UInt} = ($melody[2] Z $melody[1]).map: { |$_ };

    # Note: sort() on a Map object defaults to sort (ascending) by keys

    $reorder ~= %perm2note.sort.map( { .value } ).join: ' ';

    return $reorder;
}

#-------------------------------------------------------------------------------
sub parse-input( Str:D $name, Str:D $notes, List:D[UInt:D] $perms --> Melody:D )
#-------------------------------------------------------------------------------
{
    $name.chars > 0 or error( 'Empty composer name' );

    my Melody $melody    = ($name, Array[Note].new, Array[UInt].new);
    my Str    @note-strs =  $notes.split: / \s+ /, :skip-empty;

    for @note-strs -> Str $note-str
    {
        $note-str ~~ Note or error( qq["$note-str" is not a valid note] );
        $melody[1].push: $note-str;
    }

    $melody[1].elems > 0 or error( 'No notes supplied' );

    my UInt @perms = $perms.map: { +$_ };

    @perms.sort cmp (1 .. $melody[1].elems) eq 'Same'
        or error( 'Invalid permutation' );

    $melody[2].push: |@perms;

    return $melody;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $composer, $notes-str, $perms-str, $expected) =
                $line.split: '|';

        for     $test-name, $composer, $notes-str, $perms-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt   @perms   = $perms-str.split( / \s+ /, :skip-empty )
                                       .map: { .Int };
        my Melody $melody  = parse-input( $composer, $notes-str, @perms );
        my Str    $reorder = reorder-notes( $melody );

        is $reorder, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
        Example 1|Bach|C D E F# G A B|7 1 6 2 5 3 4|BACH => D F# A B G E C
        Example 2|Beethoven|C D F# G Ab|1 3 5 2 4|BEETHOVEN => C G D Ab F#
        Example 3|Brahms|C Db Eb F G Ab Bb C D|9 3 7 1 8 5 2 6 4|              \
                  BRAHMS => F Bb Db D Ab C Eb G C
        Example 4|Bruckner|G F# Bb C D Eb F|4 7 2 6 1 5 3|                     \
                  BRUCKNER => D Bb F G Eb C F#
        Example 5|Berg|C#|1|BERG => C#
        END

    return S:g/ \s+ \\ \n \s* / / given $data;
}

################################################################################
