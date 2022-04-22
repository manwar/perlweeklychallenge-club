#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use HTTP::Tiny;
use constant DEFAULT_BOOK_URL =>
  'https://www.gutenberg.org/cache/epub/308/pg308.txt';
use FindBin '$Bin';
use List::Util 'sum';

# Assume Unixish filesystem
my $dictionary_file = shift // "$Bin/../../../data/dictionary.txt";
my $book_url = shift // DEFAULT_BOOK_URL;

my $dictionary = read_dictionary($dictionary_file);
my $book = get_stuff($book_url);
my $model = markov_model($book, $dictionary);

my ($src, $word, %hits, @trail);
while (keys(%hits) < 26) {
   $src = $model->{$word // ''} // $dictionary;
   push @trail, $word = random_word_draw($src);
   ++$hits{$_} for split m{}mxs, $word;
}

say join ' ', @trail;

sub random_word_draw ($weighted_candidates) {
   my $total = sum values $weighted_candidates->%*;
   my $draw = rand $total; # definitely space for improvement...
   for my $word (keys $weighted_candidates->%*) {
      $draw -= $weighted_candidates->{$word};
      return $word if $draw < 0;
   }
   die "unreached, hopefully\n";
}

sub read_dictionary ($filename) {
   open my $fh, '<:encoding(utf-8)', $filename or die "open(): $!\n";
   return { map {chomp; $_ => 1} readline $fh };
}

sub get_stuff ($url) {
   my $response = HTTP::Tiny->new->get($url);
   die "$response->{status} $response->{reason}\n"
      unless $response->{success};
   return $response->{content};
}

sub markov_model ($text, $dictionary) {
   my $previous = undef;
   my %successors_for;
   for my $word (split m{[^a-z]+}mxs, lc $text) {
      if ($dictionary->{$word}) {
         $successors_for{$previous}{$word}++ if defined $previous;
         $previous = $word;
      }
      else {
         $previous = undef; # restart
      }
   }
   return \%successors_for;
}
