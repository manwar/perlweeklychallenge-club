#!/usr/bin/env perl
# Perl weekly challenge 383
# Task 1:  Similar List
#
# See https://wlmb.github.io/2026/07/20/PWC383/#task-1-similar-list
use v5.36;
use List::Util qw(any all);
die <<~"FIN" unless @ARGV and @ARGV%3==0;
    Usage: $0 F0 S0 E0 F1 S1 E1...
    to find if the list of words Sn is equivalent to the
    list Fn using the list of equivalences En. Fn and Sn are
    space separated lists of words and En are semicolon
    separated lists of space separated equivalent words.
    FIN
for my($first, $second, $equivalence)(@ARGV){
    my %equivalences;
    for(split/;\s*/,$equivalence){
        my @equivalent = split " ";
        push $equivalences{$_}->@*, @equivalent for @equivalent;
    }
    my @first_words = split " ", $first;
    my @second_words= split " ", $second;
    push $equivalences{$_}->@*, $_ for @first_words;
    my $result = @first_words == @second_words
        &&
        all{
            my $f=$first_words[$_];
            my $s=$second_words[$_];
            any{$_ eq $s} $equivalences{$f}->@*
        }0..@first_words-1;
    say "First: $first\nSecond: $second\nEquivalences: $equivalence\n-> ", $result?"True":"False", "\n";
}
