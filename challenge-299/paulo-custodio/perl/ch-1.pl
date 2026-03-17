#!/usr/bin/env perl

# Perl Weekly Challenge 299 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-299/

use Modern::Perl;

my @words = split ' ', scalar(<>);
chomp(my $sentence = scalar(<>));
say replace_words($sentence, @words);

sub replace_words {
    my($sentence, @words) = @_;
    my @sentence = split ' ', $sentence;
    for (@sentence) {
        $_ = replace_word($_, @words);
    }
    return join ' ', @sentence;
}

sub replace_word {
    my($word, @words) = @_;
    for my $repl (@words) {
        if ($word =~ /^$repl/) {
            return $repl;
        }
    }
    return $word;
}
