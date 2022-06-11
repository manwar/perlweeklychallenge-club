use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 161
=========================

TASK #2
-------
*Pangrams*

Submitted by: Ryan J Thompson

A pangram is a sentence or phrase that uses every letter in the English
alphabet at least once. For example, perhaps the most well known pangram is:

  the quick brown fox jumps over the lazy dog

Using the provided [ https://github.com/manwar/perlweeklychallenge-club/
blob/master/data/dictionary.txt |dictionary], so that you don’t need to include
individual copy, generate at least one pangram.

Your pangram does not have to be a syntactically valid English sentence (doing
so would require far more work, and a dictionary of nouns, verbs, adjectives,
adverbs, and conjunctions). Also note that repeated letters, and even repeated
words, are permitted.

BONUS: Constrain or optimize for something interesting (completely up to you),
such as:

  Shortest possible pangram (difficult)
  Pangram which contains only abecedarian words (see challenge 1)
  Pangram such that each word "solves" exactly one new letter. For example,
  such a pangram might begin with (newly solved letters in bold):
      a ah hi hid die ice tea ...
      What is the longest possible pangram generated with this method? (All
      solutions will contain 26 words, so focus on the letter count.)
  Pangrams that have the weirdest (PG-13) Google image search results
  Anything interesting goes!

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Bonus Constraint
----------------
Approximation to the shortest possible pangram using a version of the greedy
algorithm. See my blog at https://www.perlmonks.com/index.pl?node_id=11143246

=end comment
#==============================================================================

my Str  constant $DICTIONARY = 'dictionary.txt';
my      constant %ALPHABET   =  a =>  1, b =>  3, c => 3, d => 2, e => 1,
                                f =>  4, g =>  2, h => 4, i => 1, j => 8,
                                k =>  5, l =>  1, m => 3, n => 1, o => 1,
                                p =>  3, q => 10, r => 1, s => 1, t => 1,
                                u =>  1, v =>  4, w => 4, x => 8, y => 4,
                                z => 10;
my UInt constant $DUP-WEIGHT =  4;
my Bool constant $TIMER      =  True;
my Bool constant $VERBOSE    =  False;

#------------------------------------------------------------------------------
# Lexical variable with file scope
#------------------------------------------------------------------------------

my List %Word2letters;                          # Each hash entry has the form:
                       # word => [ set-of-unused-letters-in-that-word, weight ]

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 161, Task #2: Pangrams (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my Instant $t0 = now                                             if $TIMER;

    read-words( $DICTIONARY );  # Words are read from the dictionary file, fil-
                                # tered, weighted, then stored in %Word2letters

    my Str  @pangram;
    my UInt $letter-count = 0;

    while $letter-count < %ALPHABET.keys.elems
    {
        my (Str $new-word, Set[Str] $new-letters) = get-next-word();

        @pangram.push: $new-word;

        $letter-count += record-new-letters( $new-letters );
    }

    my UInt $length = [+] @pangram.map: { .chars };

    "%sPangram of %d letters using words drawn from %s:\n\n  %s\n".printf:
        $VERBOSE ?? "\n" !! '', $length, $DICTIONARY, @pangram.join: ' ';

    "\n%.2f seconds\n".printf: now - $t0                             if $TIMER;
}

#------------------------------------------------------------------------------
sub read-words( Str:D $file )
#------------------------------------------------------------------------------
{
    my Array[Str] %words{Str};

    for $DICTIONARY.IO.lines -> Str $word
    {
        my Set[Str] $set = Set[Str].new: $word.split: '', :skip-empty;
        my Str      $key = $set.keys.sort.join: '';

        %words{ $key }.push: $word;
    }

    # Where words share the same set of letters, keep only the shortest word.
    # E.g., "abdicate", "diabetic", and "abdicated" all have the letter set (a,
    # b, c, d, e, i, t), so "abdicate" is retained but "diabetic" and "abdicat-
    # ed" are filtered out. This reduces the dictionary size from 39,172 to
    # 23,610 -- a saving of 15,562 words!

    for %words.keys -> Str $key
    {
        my Str $word = %words{ $key }.sort( { $^a.chars <=> $^b.chars } )[ 0 ];

        my Set[Str] $set    = Set[Str].new: $word.split: '', :skip-empty;
        my UInt     $weight = [+] $set.keys.map: { %ALPHABET{ $_ } };

        %Word2letters{ $word } = $set, $weight;
    }
}

#------------------------------------------------------------------------------
sub get-next-word( --> List:D[Str:D, Set:D[Str:D]] )
#------------------------------------------------------------------------------
{
    state UInt $word-count = 0                                     if $VERBOSE;
    my    Str  @sorted     = %Word2letters.keys.sort: &by-size;
              +@sorted     or die 'No words left, stopped';

    my    Str  $best-word  = @sorted[ 0 ];

    %Word2letters{ $best-word }[ 0 ].elems
                            or die 'The best word has no new letters, stopped';

    my    Set[Str] $best-letters = %Word2letters{ $best-word }[ 0 ];
    state UInt     $width        = $best-word.chars + 1            if $VERBOSE;

    "(%d) %-*s".printf: ++$word-count, $width, "$best-word:"       if $VERBOSE;

    %Word2letters{ $best-word}:delete;

    for %Word2letters.keys -> Str $word
    {
        my Set[Str] $letters = %Word2letters{ $word }[ 0 ] (-) $best-letters;
        my Int      $weight  = [+] $letters.keys.map: { %ALPHABET{ $_ } };

        for $word.split: '', :skip-empty -> Str $letter
        {
           $weight -= $DUP-WEIGHT unless $letter ∈ $letters;
        }

        %Word2letters{ $word } = [ $letters, $weight ];
    }

    return [ $best-word, $best-letters ];
}

#------------------------------------------------------------------------------
sub by-size
#------------------------------------------------------------------------------
{
    # - First, prefer words with the greatest weight;
    # - then prefer words with the greatest number of unused letters;
    # - then prefer shorter words;
    # - then sort alphabetically (ascending)

    return    %Word2letters{ $^b }[ 1 ] <=> %Word2letters{ $^a }[ 1 ]
                                        ||
        %Word2letters{ $^b }[ 0 ].elems <=> %Word2letters{ $^a }[ 0 ].elems
                                        ||
                              $^a.chars <=> $^b.chars
                                        ||
                                    $^a cmp $^b;
}

#------------------------------------------------------------------------------
sub record-new-letters( Set:D[Str:D] $best-letters --> UInt:D )
#------------------------------------------------------------------------------
{
    state Bool %used  = %ALPHABET.keys.map: { $_ => False };
    my    UInt $count = 0;

    for $best-letters.keys.sort -> Str $letter
    {
        unless %used{ $letter }
        {
            %used{ $letter } = True;
            ++$count;
            " $letter".print                                       if $VERBOSE;
        }
    }

    put()                                                          if $VERBOSE;

    return $count;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
