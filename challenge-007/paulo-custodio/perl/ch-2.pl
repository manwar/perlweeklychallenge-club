#!/usr/bin/perl

# Challenge 007
#
# Challenge #2
# Word Ladder
# A word ladder is a sequence of words [w0, w1, …, wn] such that each word wi
# in the sequence is obtained by changing a single character in the word wi-1.
# All words in the ladder must be valid English words.
#
# Given two input words and a file that contains an ordered word list,
# implement a routine (e.g., find_shortest_ladder(word1, word2, wordlist))
# that finds the shortest ladder between the two input words. For example,
# for the words cold and warm, the routine might return:
#
# ("cold", "cord", "core", "care", "card", "ward", "warm")
#
# However, there’s a shortest ladder:
# (“cold”, “cord”, “card”, “ward”, “warm”).
#
# Givens:
# All words in the list have the same length.
#
# All words contain only lowercase alphabetical characters.
#
# There are no duplicates in the word list.
#
# The input words aren’t empty and aren’t equal but they have the same length
# as any word in the word list.
#
# Requirements:
# The routine must return a list of the words in the ladder if it exists.
# Otherwise, it returns an empty list.
#
# If any of the input words is the wrong length (i.e., its length is different
# to a random from the word list) or isn’t in the word list, return an empty
# list.

use strict;
use warnings;
use 5.030;

# get arguments
sub get_args {
    @ARGV==2 or die "Usage: ch-2.pl word1 word2\n";
    my($word1, $word2) = @ARGV;
    length($word1)==length($word2) or die "words must have the same length\n";
    $word1 ne $word2 or die "words must be different\n";
    for ($word1, $word2) {
        /^[a-z]+$/ or die "words must have lower case letters only\n";
    }
    return ($word1, $word2)
}

# read wordlist from dictionary
sub read_words {
    my($file, $length) = @_;

    my %wordlist;
    open(my $fh, "<", $file) or die "open $file: $!\n";
    while (<$fh>) {
        chomp;
        next unless length($_)==$length;
        next unless /^[a-z]+$/;
        $wordlist{$_} = 1;
    }
    return %wordlist;
}

# find shortest ladder
sub find_shortest_ladder {
    my($word1, $word2, %wordlist) = @_;
    my @queue = [$word1, [$word1], {$word1=>1}];    # [node, path, visited]
    while (@queue) {
        my($word, $path, $visited) = @{shift @queue};
        my @next = next_possible_words($word, \%wordlist, $visited);
        for my $next (@next) {
            return (@$path, $next) if $next eq $word2;  # found solution
            push @queue, [$next, [@$path, $next], {%$visited, $next=>1}];
        }
    }
    return ();  # no solution found
}

# find possible next words from %wordlist and not yet %visited
sub next_possible_words {
    my($word, $wordlist, $visited) = @_;
    my @next;
    for (sort keys %$wordlist) {
        push @next, $_ if $_ ne $word && !$visited->{$_} && word_diff($_, $word)==1;
    }
    return @next;
}

sub word_diff {
    my($word1, $word2) = @_;
    my $diff = 0;
    for (0 .. length($word1)-1) {
        $diff++ if substr($word1,$_,1) ne substr($word2,$_,1);
    }
    return $diff;
}


# main
sub solve {
    my($word1, $word2) = get_args();
    my %wordlist = read_words("words.txt", length($word1));
    my @ladder = find_shortest_ladder($word1, $word2, %wordlist);
    say "(", join(", ", map {'"'.$_.'"'} @ladder), ")";
}

solve;
