use v5.20;
use strict;
use warnings;

my $word = shift or die "usage: $0 [-s] <word> [<dictfile>]";
my $simple;
if ($word eq '-s') { # only simple one word anagrams.
    $simple = 1;
    $word = shift;
}
my $dorw = join "", sort split //, lc $word;

my @words = sort <>;
chomp @words;

if ($simple) {
    for (@words) {
        say if $dorw eq join "", sort split //, lc;
    }
}
else {
    # Brute force algorithm to find all word combinations that add up
    # to an anagram. Pretty slow for long input words and /usr/share/dict/words
    sub anagram {
        my ($letters, @result) = @_;
      WORD:
        for my $word (@words) {
            # /usr/share/dict/words contains all single chars. Boring.
            next if length $word == 1;

            # speed up 5 times by skipping words that contain unwanted chars
            next if $word =~ /[^$letters']/i;

            # allow ', ignore case
            my @characters = grep { $_ ne "'" } split //, lc $word;

            # skip words that are too long anyway
            next if @characters > length $letters;

            my $rest = $letters;
            foreach my $c (@characters) {
                next WORD unless $rest =~ s/$c//;
            }
            if ($rest) {
                anagram($rest, @result, $word);
            }
            else {
                say join " ", @result, $word;
            }
        }
    }
    
    anagram($dorw);
}
 
