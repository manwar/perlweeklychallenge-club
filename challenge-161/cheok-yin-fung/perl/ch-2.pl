#!/usr/bin/perl
# The Weekly Challenge 161
# Task 2 Pangrams

# BONUS: Doing The 3rd Suggestion, 
# "Pangram such that each word "solves" exactly one new letter. 
# For example, such a pangram might begin with:
#    a ah hi hid die ice tea ..."

use v5.22.0;
use warnings;
use List::Util qw/uniqstr all shuffle/;
use Data::Dumper;


# Import Word List

open DICT, "dictionary.txt" or die "unable to get the dictionary.\n";

my @pan;

my @words;  # given it is about 30_000 words in the dictionary

foreach (<DICT>) {
    chomp($_);
    push @words, $_;   
}


# if the dictionary is very large, 
# using only 3- and 4-letter words might improve the execution time
# my @three_letter_words = grep {length $_ == 3} @words;
# my @four_letter_words = grep {length $_ == 4} @words;



# Start Looking for Pangram

my %found_alphabet;


do {
    %found_alphabet = ();
    @pan = qw/a ah hi hid/;        # from task statement
    update_found();

    while (scalar @pan < 26 && defined($pan[-1])) {
        push @pan, next_pan();
        update_found();
    }
    say join " ", @pan if scalar @pan == 26;
} while (!is_pangram(@pan));



# ======================= Subroutines =====================

sub update_found {
    $found_alphabet{lc $_} = 1 for split "" , join "", @pan;
}



sub next_pan {
    my $new_word;
    my $fine = 0;
    for my $w (shuffle (@words)) {
        if ((scalar grep { !$found_alphabet{$_} } split "", $w) == 1) {
            $new_word = $w;
            $fine = 1;
            last;
        }
    }
    warn "Cannot find new words\n" if !$fine;
    return $new_word if $fine;
}



# TESTING Subroutine

sub is_pangram {
    my @components = @_;
    my %test;
    $test{$_} = 0 for ("a".."z");
    $test{$_} = 1 for split "" , join "", @components;
    return all {$test{$_} == 1} keys %test;
}

