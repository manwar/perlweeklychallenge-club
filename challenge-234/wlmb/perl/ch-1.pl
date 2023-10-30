#!/usr/bin/env perl
# Perl weekly challenge 234
# Task 1:  Common Characters
#
# See https://wlmb.github.io/2023/09/11/PWC234/#task-1-common-characters
use v5.36;
use List::Util qw(min);
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 [W2...]
    to find the common characters in all words W1, W2...
    FIN
my @letters_of_word;
for(@ARGV){
    my %count_of_letter;
    $count_of_letter{$_}++ for split "";
    push @letters_of_word, \%count_of_letter;
}
my $number_of_words=@letters_of_word;
my @result=map {
    my $letter=$_;
    my $repetition=min map {
	my $word_number=$_;
	$letters_of_word[$word_number]{$letter}//0
    } 0..$number_of_words-1;
    ($letter) x $repetition;
} keys %{$letters_of_word[0]};
say "@ARGV -> @result";
