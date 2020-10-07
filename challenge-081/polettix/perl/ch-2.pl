#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use autodie;

sub frequency_sort ($input = 'input') {

   # Allow for getting an open filehandle as input
   my $fh = ref($input) ? $input : do {open my $fh, '<', $input; $fh};

   # Count occurrences for all words, just for starters
   my %count_for;
   while (<$fh>) {
      s{(?: [."(),] | 's | -- )+}{ }gmxs; # ignore stuff
      $count_for{$_}++ for grep {length > 0} split m{\s+}mxs;
   }

   # Invert "count by word" to "words by count"
   my %words_for;
   while (my ($word, $count) = each %count_for) {
      push $words_for{$count}->@*, $word;
   }

   say join "\n\n", map {
      # Sort words for $count lexicographically
      join ' ', $_, sort {$a cmp $b} $words_for{$_}->@*;
   } sort {$a <=> $b} keys %words_for;
}

frequency_sort(\*DATA);

__DATA__
West Side Story

The award-winning adaptation of the classic romantic tragedy "Romeo and
Juliet". The feuding families become two warring New York City gangs,
the white Jets led by Riff and the Latino Sharks, led by Bernardo. Their
hatred escalates to a point where neither can coexist with any form of
understanding. But when Riff's best friend (and former Jet) Tony and
Bernardo's younger sister Maria meet at a dance, no one can do anything
to stop their love. Maria and Tony begin meeting in secret, planning to
run away. Then the Sharks and Jets plan a rumble under the
highway--whoever wins gains control of the streets. Maria sends Tony to
stop it, hoping it can end the violence. It goes terribly wrong, and
before the lovers know what's happened, tragedy strikes and doesn't stop
until the climactic and heartbreaking ending.
