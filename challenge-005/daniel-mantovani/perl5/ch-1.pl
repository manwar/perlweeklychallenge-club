use strict;
use warnings;
use v5.10;
use utf8;
use open qw(:std :utf8);
use FindBin;
use Encode 'decode_utf8';

# Challenge #1
# Write a program which prints out all anagrams for a given word.
# For more information about Anagram, please check this wikipedia page.
#
# Although the challenge doesn't say, it sounds logical that you will need
# a valid list of words to find valid anagrams.
#
# As my native language is spanish, I will use a spanish version of the challenge,
# hope that will not be a problem
#
# The fact that we are not using english for the challenge adds an extra bit
# of complexity as it forces you to take care of Unicode chars,
# as the "a char is just a byte" paradigm will not work outside of english language.
# note the `use open qw(:std :utf8' line, that allow us to read utf8 encoded files,
# and also print to STDOUT utf8 encoded strings
#
# Another important issue is that in spanish, "anagramas" don't take care of accents.
# That means for example that "tender" and "tendré" are considered anagrams.
#
# Example of use:
# $> perl ch-1.pl montará
# maratón                 (means "marathon")
# mataron                 (killed (they))
# matrona                 (midwife)
# montara                 (3rd person from verb to mount, pass tense)
# montará                 (same but future tense)
# tomaran                 (will take (they))
# tomarán                 (same but future tense)
# $>

#
# We start by defining a "canonical" function that is unique for all anagrams of
# a particular word.
# canonical() just takes all letters (w/o accents), ordered in any standard (repetitive) way.
# It follows that two words are anagrams among them if and only if canonical() gives us
# the same result.
#
# example: as
#       canonical('pasó') ---> 'aops'
#          and
#       canonical('sopa') ---> 'aops'
#          it follows that 'pasó' and 'sopa' are anagrams
#

sub canonical {
    my $inp = lc shift;
    $inp =~ tr/áéíóú/aeiou/; # anagrams in spanish don't care about accents
    return join '', sort split '', $inp;
}

# The list of spanish words (near 250k) is from
# https://raw.githubusercontent.com/ManiacDC/TypingAid/master/Wordlists/WordList_SpanishAbc%20rommmcek.txt
# , then converted from ISO-8859-1 to UTF-8 with the iconv utility:
# $> iconv -f ISO-8859-1 -t UTF-8 src.txt > dest.txt
#
# the result file is renamed `palabras.txt' and located in the script directory,
# so we can read them into an array

# we use FindBin module to always find `palabras.txt' file in our script directory
open( my $words_file, "$FindBin::Bin/palabras.txt" );
my @words = <$words_file>;
chomp @words;

# now we calculate the canonical() function for the given word (shift here gets it)
# note that the given word may contain accents, or even a "ñ" letter, so we will
# need to be carefull and decode it from utf8
my $base =
  canonical( decode_utf8 shift || die "Usage: perl $0 <spanish word>" );

# now we just say any word that matches the canonical() function with the given word:
canonical($_) eq $base && say for @words;
