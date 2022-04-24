#!perl

###############################################################################
=comment

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
blob/master/data/dictionary.txt |dictionary], so that you don't need to include
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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Bonus Constraint
----------------
Approximation to the shortest possible pangram using a version of the greedy
algorithm. See my blog at https://www.perlmonks.com/index.pl?node_id=11143246

=cut
#==============================================================================

use strict;
use warnings;
use autodie;
use feature qw( state );
use Const::Fast;
use Set::Tiny;
use constant TIMER   => 1;
use constant VERBOSE => 1;

const my %ALPHABET   =>
      (
          a => 1, b =>  3, c => 3, d => 2, e => 1,
          f => 4, g =>  2, h => 4, i => 1, j => 8,
          k => 5, l =>  1, m => 3, n => 1, o => 1,
          p => 3, q => 10, r => 1, s => 1, t => 1,
          u => 1, v =>  4, w => 4, x => 8, y => 4, z => 10
      );
const my $DUP_WEIGHT =>  4;
const my $DICTIONARY => 'dictionary.txt';
const my $USAGE      => "Usage:\n  raku ch-2.raku\n";

#------------------------------------------------------------------------------
# Lexical variable with file scope
#------------------------------------------------------------------------------

my %Word2letters;    # Each hash entry has the form:
                     #   word => [ set-of-unused-letters-in-that-word, weight ]

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 161, Task #2: Pangrams (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

    my $t0   = [ gettimeofday ]                                       if TIMER;
    my $args = scalar @ARGV;
       $args and die "ERROR: Expected 0 command line arguments, found $args" .
                     "\n$USAGE";

    read_words( $DICTIONARY );  # Words are read from the dictionary file, fil-
                                # tered, weighted, then stored in %Word2letters
    my @pangram;
    my $letter_count = 0;

    while ($letter_count < scalar keys %ALPHABET)
    {
        my ($new_word, $new_letters) = get_next_word();

        push @pangram, $new_word;

        $letter_count += record_new_letters( $new_letters );
    }

    my $length  = 0;
       $length += length $_ for @pangram;

    printf "%sPangram of %d letters using words drawn from %s:\n\n  %s\n",
            VERBOSE ? "\n" : '', $length, $DICTIONARY, join ' ', @pangram;

    printf "\n%.2f seconds\n", tv_interval( $t0 ),                    if TIMER;
}

#------------------------------------------------------------------------------
sub read_words
#------------------------------------------------------------------------------
{
    my ($file) = @_;
    my  %words;

    open my $fh, '<', $file;

    while (my $word = <$fh>)
    {
        chomp $word;

        my $set = Set::Tiny->new( split '', $word );
        my $key = join '', sort $set->elements;

        push @{ $words{ $key } }, $word;
    }

    close $fh;

    # Where words share the same set of letters, keep only the shortest word.
    # E.g., "abdicate", "diabetic", and "abdicated" all have the letter set (a,
    # b, c, d, e, i, t), so "abdicate" is retained but "diabetic" and "abdicat-
    # ed" are filtered out. This reduces the dictionary size from 39,172 to
    # 23,610 -- a saving of 15,562 words!

    for my $key (keys %words)
    {
        my $word = (sort { length $a <=> length $b } @{ $words{ $key } })[ 0 ];
        my $set  =  Set::Tiny->new( split '', $word );

        my $weight  = 0;
           $weight += $ALPHABET{ $_ } for $set->elements;

        $Word2letters{ $word } = [ $set, $weight ];
    }
}

#------------------------------------------------------------------------------
sub get_next_word
#------------------------------------------------------------------------------
{
    state  $word_count = 0                                          if VERBOSE;
    my     @sorted     = sort by_size keys %Word2letters;
    scalar @sorted         or  die 'No words left, stopped';

    my     $best_word  = $sorted[ 0 ];

    $Word2letters{ $best_word }[ 0 ]->is_empty
                           and die 'The best word has no new letters, stopped';

    my     $best_letters = $Word2letters{ $best_word }[ 0 ];
    state  $width        = length( $best_word ) + 1                 if VERBOSE;

    printf "(%d) %-*s", ++$word_count, $width, "$best_word:"        if VERBOSE;

    delete $Word2letters{ $best_word };

    for my $word (keys %Word2letters)
    {
        my $letters = $Word2letters{ $word }[ 0 ]->difference( $best_letters );
        my $weight  = 0;
           $weight += $ALPHABET{ $_ } for $letters->elements;

        for (split '', $word)
        {
           $weight -= $DUP_WEIGHT unless $letters->contains( $_ );
        }

        $Word2letters{ $word } = [ $letters, $weight ];
    }

    return ($best_word, $best_letters);
}

#------------------------------------------------------------------------------
sub by_size
#------------------------------------------------------------------------------
{
    # - First, prefer words with the greatest weight;
    # - then prefer words with the greatest number of unused letters;
    # - then prefer shorter words;
    # - then sort alphabetically (ascending)

    return $Word2letters{ $b }[ 1 ] <=> $Word2letters{ $a }[ 1 ]
                                    ||
     $Word2letters{ $b }[ 0 ]->size <=> $Word2letters{ $a }[ 0 ]->size
                                    ||
                          length $a <=> length $b
                                    ||
                                 $a cmp $b;
}

#------------------------------------------------------------------------------
sub record_new_letters
#------------------------------------------------------------------------------
{
    state %letters       = map { $_ => 0 } keys %ALPHABET;
    my   ($best_letters) = @_;
    my    $count         = 0;

    for my $letter (sort $best_letters->elements)
    {
        if ($letters{ $letter } == 0)
        {
            $letters{ $letter } =  1;
            ++$count;
            print " $letter"                                        if VERBOSE;
        }
    }

    print "\n"                                                      if VERBOSE;

    return $count;
}

###############################################################################
