#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use List::Util 'sum';

say word_stickers(@ARGV);

sub word_stickers ($word, @stickers) {
   my %needed = letters_histogram($word);

   # collect whatever is deemed sufficient
   my %provided;
   for my $sticker (@stickers) {
      my %available = letters_histogram($sticker);
      for my $letter (keys(%needed)) {
         my $available = $available{$letter} or next;
         $provided{$letter}{$sticker} = $available;
      }
   }

   # check for a viable solution and set the bare minimum
   my %minimum;
   for my $letter (keys(%needed)) {
      my $alternatives = $provided{$letter}
         or return 0; # no viable source
      if (scalar(keys($alternatives->%*)) == 1) { # one viable source only
         my ($word, $units) = $alternatives->%*;
         my $amount = int($needed{$letter} / $units)
            + ($needed{$letter} % $units ? 1 : 0);
         my $amount = $units;
         $minimum{$word} = $amount
            if (! exists($minimum{$word})) || ($minimum{$word} < $amount);
      }
   }

   # use whatever minimum we set to lower needs, where possible
   for my $letter (keys(%needed)) {
      my $needed = delete $needed{$letter};
      for my $source (keys($provided{$letter}->%*)) {
         $needed -= ($minimum{$source} // 0) * $provided{$letter}{$source};
      }
      $needed{$letter} = $needed if $needed > 0; # restore missing
   }

   # if we're left with needs, we have to do some searching, breadth first
   %minimum = complete_minimum(\%minimum, \%needed, \%provided)
      if scalar(keys(%needed));

   return sum(values(%minimum));
}

sub complete_minimum ($minimum, $needed, $provided) {
   my @queue = ({needed => {$needed->%*}, minimum => {$minimum->%*}});
   while (@queue) {
      my $frame = shift(@queue);
      my $needed = $frame->{needed};
      my $minimum = $frame->{minimum};

      my %words = map { $_ => 1 }
         map { keys($provided->{$_}->%*) } keys($needed->%*);
      for my $source (keys %words) {
         my %nmin  = $minimum->%*;
         $nmin{$source}++;
         my %nneed = $needed->%*;
         for my $letter (keys(%nneed)) {
            $nneed{$letter} -= $provided->{$letter}{$source} // 0;
            delete($nneed{$letter}) if $nneed{$letter} <= 0;
         }
         return %nmin if scalar(keys(%nneed)) == 0;
         push @queue, {needed => \%nneed, minimum => \%nmin};
      }
   }
}

sub letters_histogram ($word) {
   my %amount_for;
   $amount_for{substr($word, $_, 1)}++ for 0 .. length($word) - 1;
   return %amount_for;
}
