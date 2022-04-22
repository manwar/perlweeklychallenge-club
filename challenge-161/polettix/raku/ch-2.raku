#!/usr/bin/env raku
use v6;
use HTTP::Tiny;

constant \DEFAULT_BOOK_URL =
  'https://www.gutenberg.org/cache/epub/308/pg308.txt';

sub MAIN (Str:D $dictionary-file, Str:D $book-url = DEFAULT_BOOK_URL) {
   my $dictionary = read-dictionary($dictionary-file);
   my $book = get-stuff($book-url);
   my $model = markov-model($book, $dictionary);

   my ($src, $word, %hits);
   my @trail = gather while %hits.elems < 26 {
      $src = $model{$word // ''} // $dictionary;
      take $word = random-word-draw($src);
      ++%hits{$_} for $word.comb;
   };
   @trail.join(' ').put;
}

sub random-word-draw ($weighted-candidates) {
   my $total = $weighted-candidates.values.sum;
   my $draw = $total.rand;
   for $weighted-candidates.kv -> $word, $weight {
      $draw -= $weight;
      return $word if $draw < 0;
   }
   die "unreached, hopefully\n";
}

sub read-dictionary ($filename) {
   $filename.IO.words.map({$_ => 1}).Hash;
}

sub get-stuff ($url) {
   my $response = HTTP::Tiny.new.get($url);
   die "$response<status> $response<reason>\n"
      unless $response<success>;
   return $response<content>.decode;
}

sub markov-model ($text, $dictionary) {
   my $previous = Nil;
   my $successors-for;
   for $text.lc.split(/<-[ a..z ]>/) -> $word {
      if $dictionary{$word}:exists {
         $successors-for{$previous}{$word}++ if defined $previous;
         $previous = $word;
      }
      else {
         $previous = Nil; # restart
      }
   }
   return $successors-for;
}
