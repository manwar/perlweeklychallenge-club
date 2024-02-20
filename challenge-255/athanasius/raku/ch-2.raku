use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 255
=========================

TASK #2
-------
*Most Frequent Word*

Submitted by: Mohammad Sajid Anwar

You are given a paragraph $p and a banned word $w.

Write a script to return the most frequent word that is not banned.

Example 1

  Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
         $w = "hit"
  Output: "ball"

  The banned word "hit" occurs 3 times.
  The other word "ball" occurs 2 times.

Example 2

  Input: $p = "Perl and Raku belong to the same family. Perl is the most popular
               language in the weekly challenge."
         $w = "the"
  Output: "Perl"

  The banned word "the" occurs 3 times.
  The other word "Perl" occurs 2 times.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to True, the output is followed by a short explanation like
   those in the Examples.

Assumptions
-----------
1. "Words" are composed of the letters A-Z, a-z, and ' (the apostrophe) ONLY.
2. Different forms of the same root word are treated as different words:
   "belong", "belongs", and "belonged" are 3 distinct words; "Perl" and "Perl's"
   are 2 distinct words.
3. Hyphenated words are not recognised as such: e.g., "cul-de-sac" is treated
   as 3 separate words.
4. Capitalisation.
   If a word appears with its initial letter both capitalised and uncapitalised,
   AND each occurrence of the capitalised version appears at the beginning of a
   sentence, then (and only then) the different forms are considered to be a
   single word, and that word's uncapitalised form is treated as canonical.
5. If two or more words share the same maximum frequency of occurrence, the
   alphabetically-first word is given as the output.

=end comment
#===============================================================================

use Test;

my UInt constant SCREEN-WIDTH = 80;
my UInt constant TAB          = 14;
my Bool constant VERBOSE      = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 255, Task #2: Most Frequent Word (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $p where { m:i/   <[ a .. z ]>    / },          #= A paragraph of text
    Str:D $w where { m:i/ ^ <[ a .. z ]>+ $ / }           #= A banned word
)
#===============================================================================
{
    qq[Input:  \$p = "%s"\n].printf: split-paragraph( $p );
    qq[        \$w = "$w"].put;

    my %result = find-most-freq-word( $p, $w );

    if %result< words >.elems == 0
    {
        'Output: <none>'.put;
    }
    else
    {
        qq[Output: "%s"\n].printf: %result< words >[ 0 ];
    }

    explain( $w, %result ) if VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-most-freq-word( Str:D $p, Str:D $w --> Hash:D )
#-------------------------------------------------------------------------------
{
    # Remove (by replacing with spaces) all non-word characters, but leave 
    # apostrophes and sentence-ending punctuation characters in place

    my Str $p1 = S:g/ <-[ A .. Z a .. z ' . ? ! \s ]> / / given $p;

    my UInt %first-words = find-first-words( $p1 );  # Words beginning sentences

    $p1 ~~ s:g/ <[ . ? ! ]> / /;                   # Remove sentence terminators

    # Record all words, together with their frequencies of occurrence

    my UInt %dict;
          ++%dict{ $_ } for $p1.split: / \s+ /, :skip-empty;

    merge-words( %first-words, %dict );  # Merge capitalised/uncapitalised pairs

    my %result;

    remove-banned-word( $w, %dict, %result );

    my UInt $max-freq   = %dict.elems ?? (%dict<>:v.max) !! 0;
    %result< max-freq > = $max-freq;
    my Str  @words      = grep { %dict{ $_ } == $max-freq }, %dict<>:k;
    %result< words >    = Array[Str].new: @words.sort;

    return %result;
}

#-------------------------------------------------------------------------------
sub find-first-words( Str:D $p --> Hash:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my @matches = $p ~~ m:g/ [ ^ \s* || <[ . ? ! ]> \s+ ] (<[ A .. Z ]> \S*) /;

    my UInt %first-words;
          ++%first-words{ $_ } for @matches.map: { $_[ 0 ] };

    return %first-words;
}

#-------------------------------------------------------------------------------
sub merge-words( Hash:D[UInt:D] $first-words, Hash:D[UInt:D] $dict )
#-------------------------------------------------------------------------------
{
    for $first-words<>:k -> Str $word
    {
        my Str $lc-word = $word.subst( / ^ (.) /, { $0.lc } );

        if $dict{ $lc-word }:exists && $first-words{ $word } == $dict{ $word }
        {
            $dict{ $lc-word } += $dict{ $word };
            $dict{ $word }:delete;
        }
    }
}

#-------------------------------------------------------------------------------
sub remove-banned-word( Str:D $w, Hash:D[UInt:D] $dict, %result )
#-------------------------------------------------------------------------------
{
    %result< banned-word > = 0;

    if $dict{ $w }:exists                  # Remove the banned word
    {
        %result< banned-word > = $dict{ $w };
        $dict{ $w }:delete;
    }
    else
    {
        my Str $lc-bw = $w.subst( / ^ (.) /, { $0.lc } );

        if $dict{ $lc-bw }:exists
        {
            %result< banned-word > = $dict{ $lc-bw };
            $dict{ $lc-bw }:delete;        # Remove the banned word's lc version
        }
    }
}

#-------------------------------------------------------------------------------
sub explain( Str:D $w, %result )
#-------------------------------------------------------------------------------
{
    my UInt $w-freq = %result< banned-word >;

    qq[\nThe banned word "%s" occurs %d time%s\n].printf:
        $w, $w-freq, $w-freq == 1 ?? '' !! 's';

    my UInt       $freq  = %result< max-freq >;
    my Array[Str] $words = %result< words >;
    my UInt       $count = $words.elems;

    if $count == 0
    {
        'There are no other words'.put;
    }
    else
    {
        qq[The other  word%s %s occur%s %d time%s%s\n].printf:
            ($count == 1 ?? ''  !! 's'),
             $words.map( { qq["$_"] } ).join( ', ' ),
            ($count == 1 ?? 's' !! ''),
             $freq,
            ($freq  == 1 ?? ''  !! 's'),
            ($count == 1 ?? ''  !! ' each');
    }
}

#-------------------------------------------------------------------------------
sub split-paragraph( Str:D $p is copy --> Str:D )
#-------------------------------------------------------------------------------
{
    # Insert "\n<tab>" at every SCREEN-WIDTH position in $p

    my Str $insert = "\n" ~ ' ' x TAB;

    loop (my UInt $i = SCREEN-WIDTH - TAB; $i < $p.chars; $i += SCREEN-WIDTH)
    {
        --$i while $p.substr( $i, 1 ) ~~ / \S /;
        
        $p.substr-rw( $i, 1 ) = $insert;
    }

    return $p;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    my Str $test-data = S:g/ \+ \n \s* // with test-data();

    for $test-data.lines -> Str $line
    {
        my Str ($test-name, $p, $w, $expected) = $line.split: / \| /;

        for     $test-name, $p, $w, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my %result = find-most-freq-word( $p, $w );

        is %result< words >[ 0 ], $expected, $test-name;
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
        Example 1 |Joe hit a ball, the hit ball flew far after it was hit.|hit|+
                   ball
        Example 2 |Perl and Raku belong to the same family. Perl is the most   +
                   popular language in the weekly challenge.|the|Perl
        Gettysburg|But, in a larger sense, we can not dedicate—we can not      +
                   consecrate—we can not hallow-this ground. The brave men,    +
                   living and dead, who struggled here, have consecrated it,   +
                   far above our poor power to add or detract. The world will  +
                   little note, nor long remember what we say here, but it can +
                   never forget what they did here. It is for us the living,   +
                   rather, to be dedicated here to the unfinished work which   +
                   they who fought here have thus far so nobly advanced. It is +
                   rather for us to be here dedicated to the great task        +
                   remaining before us-that from these honored dead we take    +
                   increased devotion to that cause for which they gave the    +
                   last full measure of devotion-that we here highly resolve   +
                   that these dead shall not have died in vain—that this       +
                   nation, under God, shall have a new birth of freedom-and    +
                   that government of the people, by the people, for the       +
                   people, shall not perish from the earth.|the|here
        Case 1    |Perl and Raku belong to the same family. Perl is the most   +
                   popular language in the weekly challenge.|The|Perl
        Case 2    |x y a? X w a u! X ab a c and x|unknown|x
        END
}

################################################################################

# For ease of copy/paste onto the command line:
#`(
But, in a larger sense, we can not dedicate—we can not consecrate—we can not hallow—this ground. The brave men, living and dead, who struggled here, have consecrated it, far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced. It is rather for us to be here dedicated to the great task remaining before us—that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion—that we here highly resolve that these dead shall not have died in vain—that this nation, under God, shall have a new birth of freedom—and that government of the people, by the people, for the people, shall not perish from the earth.
)

################################################################################
