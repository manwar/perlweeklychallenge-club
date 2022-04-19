#!/usr/bin/env perl
# Perl weekly challenge 161
# Task 2: Pangrams
#
# See https://wlmb.github.io/2022/04/11/PWC160/#task-2-pangrams
use v5.12;
use warnings;
use List::Util qw(notall uniq shuffle first);
die "Usage: ./ch-2.pl dictionary\n".
    "to find an abedecedarian pangram from the given dictionary..."
    unless @ARGV==1;
die "Can't read dictionary" unless -r $ARGV[0];
my @dictionary=map {chomp; $_} <>; # read the dictionary
my @abecedarian=grep {$_ eq join "", sort {$a cmp $b} split "", $_} @dictionary;
my %words_with; # maps letters to words containing them
for my $word(@abecedarian){
    push @{$words_with{$_}},$word for uniq split "", $word;
}
my %letters;
my $pangram;
my @all_letters='a'..'z';
while(notall {$letters{$_}} @all_letters){
    my $letter=first {!$letters{$_}} shuffle @all_letters; # random missing letter
    my @possible_words=@{$words_with{$letter}}; # words containing letter
    my $word=$possible_words[rand @possible_words]; # choose a random one
    $pangram.=" ".$word; # add to output phrase
    ++$letters{$_} for split "", $word; # update used letters
}
say $pangram;
