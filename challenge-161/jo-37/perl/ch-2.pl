#!/usr/bin/perl

use v5.16;
use warnings;
use constant DICT => '../../../data/dictionary.txt';
use List::Util 'reduce';
use experimental 'postderef';

# Additional constraints:
# - The pangram shall consist of words having distinct letters.
# - It shall be minimal in the sense that the removal of any of the
#   words would break the pangram.
#
# Specify the name of a dictionary as an argument or use the provided
# dictionary otherwise.
#
# Call "./ch-1.pl | ./ch-2.pl -" to produce pangrams of abecedarian
# words.

main: {
    srand;

    # Use the provided dictionary if none was specified.
    $ARGV[0] = DICT unless @ARGV;
    my %letters;
    my @words;
    # Collect all words from the dictionary that consist of distinct
    # letters and record the word's index for all of its letters.
    # All letters found in the distinct letter words will be covered by
    # the final pangram.
    while (<>) {
        chomp;
        (my $letters)->@{split //} = ();
        next if keys %$letters < length;
        push $letters{$_}->@*, scalar @words for keys %$letters;
        push @words, $_;
    }

    {
        # Select a (random) word from each letter's list to assure full
        # coverage.
        my %selection = map {
            ($letters{$_}[int rand $letters{$_}->@*] => undef)
        } keys %letters;

        # Rebuild the letter-to-word map for the selection.
        %letters = ();
        for my $word (keys %selection) {
            push $letters{$_}->@*, $word for split //, $words[$word];
        }
    }

    # The following steps were inspired by the Quine-McCluskey
    # algorithm.

    # Pick all words that are singletons in at least one letter's list
    # and thus are required.
    my %picked = map {@$_ == 1 ? ($_->[0] => undef) : ()} values %letters;

    # Remove all letters that are covered by the picked words.
    delete @letters{split //, $words[$_]} for keys %picked;

    # Chose words from the selection to cover the remaining letters.
    while (keys %letters) {
        # Count the number of remaining letters that are covered by each
        # word.
        my %coverage;
        for my $letter (keys %letters) {
            $coverage{$_}++ for $letters{$letter}->@*;
        }

        # Pick the shortest word having a maximum coverage from the
        # selection and remove the covered letters.
        my $pick = reduce {
            ($coverage{$a} <=> $coverage{$b} ||
            length($words[$b]) <=> length($words[$a])) > 0 ? $a : $b
        } map $_->@*, values %letters;
        $picked{$pick} = undef;
        delete @letters{split //, $words[$pick]};
    }

    # Present the pangram.
    say "@{[map $words[$_], keys %picked]}";
}
