use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 076
=========================

Task #2
-------
*Word Search*

Submitted by: Neil Bowers
Reviewed by:  Ryan Thompson

Write a script that takes two file names. The first file would contain word
search grid as shown below. The second file contains list of words, one word per
line. You could even use local dictionary file.

Print out a list of all words seen on the grid, looking both orthogonally and
diagonally, backwards as well as forwards.

Search Grid

 B I D E M I A T S U C C O R S T
 L D E G G I W Q H O D E E H D P
 U S E I R U B U T E A S L A G U
 N G N I Z I L A I C O S C N U D
 T G M I D S T S A R A R E I F G
 S R E N M D C H A S I V E E L I
 S C S H A E U E B R O A D M T E
 H W O V L P E D D L A I U L S S
 R Y O N L A S F C S T A O G O T
 I G U S S R R U G O V A R Y O C
 N R G P A T N A N G I L A M O O
 E I H A C E I V I R U S E S E D
 S E T S U D T T G A R L I C N H
 H V R M X L W I U M S N S O T B
 A E A O F I L C H T O D C A E U
 Z S C D F E C A A I I R L N R F
 A R I I A N Y U T O O O U T P F
 R S E C I S N A B O S C N E R A
 D R S M P C U U N E L T E S I L

Output

Found 55 words of length 5 or more when checked against the local dictionary.
You may or may not get the same result but that is fine.

argos, constitution, margo, patna, traci, tracie, aimed, align, antes, arose,
ashed, blunt, blunts, broad, buries, clove, cloven, constitution, constitutions,
croon, depart, departed, enter, filch, garlic, goats, grieve, grieves, hazard,
liens, malign, malignant, malls, midst, ought, ovary, parted, pudgiest, quash,
quashed, raped, ruses, shrine, shrines, social, socializing, spasm, spasmodic,
succor, succors, theorem, theorems, virus, viruses, wigged

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Str  constant $LIB-DIR            =  $*PROGRAM.dirname ~ '/../lib';
my Str  constant $DEFAULT-GRID-FILE  = "$LIB-DIR/example-grid.txt";
my Str  constant $DEFAULT-DICT-FILE  = "$LIB-DIR/linuxwords.txt";
my UInt constant $DEFAULT-MIN-LENGTH =  5;
my UInt constant $SCREEN-WIDTH       = 80;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 076, Task #2: Word Search (Raku)\n".put;
}

##==============================================================================
sub MAIN
(
    #| Name of file containing a word search grid
    Str:D  :$grid where $grid.IO ~~ :f & :r = $DEFAULT-GRID-FILE,

    #| Name of a dictionary file: valid words, one per line
    Str:D  :$dict where $dict.IO ~~ :f & :r = $DEFAULT-DICT-FILE,

    #| Minimum search-word length (must be > 0)
    UInt:D :$min  where * > 0               = $DEFAULT-MIN-LENGTH,
)
##==============================================================================
{
    my Str @grid-lines = $grid.IO.slurp.split("\n", :skip-empty)
                                       .map: { S:g/ \s+ // };

    my Str @search-lines = @grid-lines;     # The horizontal lines
           @search-lines.push: $_ for get-vertical-lines(@grid-lines);
           @search-lines.push: $_ for get-diagl-dn-lines(@grid-lines);
           @search-lines.push: $_ for get-diagl-up-lines(@grid-lines);

    my Str %dictionary = create-dictionary($dict, $min);

    my UInt %found = search-grid($min, %dictionary, @search-lines);

    "Found { %found.elems } different words of length $min or more:\n".put;
    print-words(%found);
}

#-------------------------------------------------------------------------------
sub search-grid( UInt:D $min-len, Str:D %dict, Str:D @lines --> Hash:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt %found;

    for @lines -> Str $line
    {
        my UInt $line-length = $line.chars;

        if $line-length >= $min-len
        {
            # Search each line both forwards and backwards

            for $line, $line.flip -> Str $search-space
            {
                for 0 .. $line-length - $min-len - 1 -> UInt $begin
                {
                    for $begin + $min-len - 1 .. $line-length - 1 -> UInt $end
                    {
                        my Str $word = $search-space.substr($begin .. $end).lc;

                        ++%found{ %dict{ $word } } if %dict{ $word }:exists;
                    }
                }
            }
        }
    }

    return %found;
}

#-------------------------------------------------------------------------------
sub get-vertical-lines( Str:D @grid-lines --> Array:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str @search-lines;

    for 0 .. @grid-lines[0].chars - 1 -> UInt $i
    {
        my Str $search-line  = '';
               $search-line ~= .substr: $i, 1 for @grid-lines;

        @search-lines.push: $search-line;
    }

    return @search-lines;
}

#-------------------------------------------------------------------------------
sub get-diagl-dn-lines( Str:D @grid-lines --> Array:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str  @lines;
    my UInt $max-row = @grid-lines   .elems - 1;
    my UInt $max-col = @grid-lines[0].chars - 1;

    for (0 .. $max-row).reverse -> UInt $first-row
    {
        my Str  $line = '';
        my UInt $col  = 0;

        for $first-row .. $max-row -> UInt $row
        {
            $line ~= @grid-lines[$row].substr: $col, 1;
            last if ++$col > $max-col;
        }

        @lines.push: $line;
    }

    for 1 .. $max-col -> UInt $first-col
    {
        my Str  $line = '';
        my UInt $row  = 0;

        for $first-col .. $max-col -> UInt $col
        {
            $line ~= @grid-lines[$row].substr: $col, 1;
            last if ++$row > $max-row;
        }

        @lines.push: $line;
    }

    return @lines;
}

#-------------------------------------------------------------------------------
sub get-diagl-up-lines( Str:D @grid-lines --> Array:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str  @lines;
    my UInt $max-row = @grid-lines   .elems - 1;
    my UInt $max-col = @grid-lines[0].chars - 1;

    for 0 .. $max-row -> UInt $first-row
    {
        my Str  $line = '';
        my UInt $col  = 0;

        for (0 .. $first-row).reverse -> UInt $row
        {
            $line ~= @grid-lines[$row].substr: $col, 1;
            last if ++$col > $max-col;
        }

        @lines.push: $line;
    }

    for 1 .. $max-col -> UInt $first-col
    {
        my Str  $line = '';
        my UInt $row  = $max-row;

        for $first-col .. $max-col -> UInt $col
        {
            $line ~= @grid-lines[$row].substr: $col, 1;
            last if --$row < 0;
        }

        @lines.push: $line;
    }

    return @lines;
}

#-------------------------------------------------------------------------------
sub create-dictionary( Str:D $dict-file, UInt:D $min-length --> Hash:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str %dictionary;

    for $dict-file.IO.lines -> Str $word
    {
        # Note: Each word is recorded twice, the key in lower case, the value in
        # its original case. For dictionaries (such as linuxwords.txt) in which
        # some words are capitalised (Aarhus, Aaron, Ababa, Abba, ...) this
        # allows retrieval of the original case following hash look-up (which
        # necessarily uses uniform case, since case is not distinguished in the
        # word search grid).

        %dictionary{ $word.lc } = $word if $word.chars >= $min-length;
    }

    return %dictionary;
}

#-------------------------------------------------------------------------------
sub print-words( Hash:D[UInt:D] $found )
#-------------------------------------------------------------------------------
{
    # Print a list of the words found *without* splitting words across lines

    my $line = '';

    for $found.keys.sort -> Str $word is copy
    {
        # Let n be the number of times "word" was found in the search grid;
        # then, if n > 1, append a count to display it as "word(n)"

        my UInt $freq = $found{ $word };

        $word ~= "($freq)" if $freq > 1;

        # Allow 3 extra characters for the preceding ', ' and the following ','

        if $line.chars + $word.chars + 3 >= $SCREEN-WIDTH
        {
           ($line ~ ',').put;
            $line = $word;
        }
        else
        {
            $line ~= ', ' if $line;
            $line ~= $word;
        }
    }

    $line.put;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s  / ($*PROGRAM-NAME) /raku $0/;
    $usage ~~ s:g/ ' where { ... }' //;

    $usage.put;
}

################################################################################
