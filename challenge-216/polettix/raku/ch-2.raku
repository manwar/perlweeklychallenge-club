#!/usr/bin/env raku
use v6;
sub MAIN (Str :$word, *@stickers) { put word-stickers($word, @stickers) }

sub word-stickers ($word, @stickers) {
   my %needed = letters-histogram($word);

   # collect whatever is deemed sufficient
   my %provided;
   for @stickers -> $sticker {
      my %available = letters-histogram($sticker);
      for %needed.keys -> $letter {
         my $available = %available{$letter} or next;
         %provided{$letter}{$sticker} = $available;
      }
   }

   # check for a viable solution and set the bare minimum
   my %minimum;
   for %needed.keys -> $letter {
      my $alternatives = %provided{$letter}
         or return 0; # no viable source
      if ($alternatives.elems == 1) { # one viable source only
         my ($word, $units) = $alternatives.kv;
         my $amount = (%needed{$letter} div $units)
            + ((%needed{$letter} % $units) ?? 1 !! 0);
         %minimum{$word} = $amount
            if %minimum{$word}:!exists || (%minimum{$word} < $amount);
      }
   }

   # use whatever minimum we set to lower needs, where possible
   for %needed.keys -> $letter {
      my $needed = %needed{$letter}:delete;
      for %provided{$letter}.keys -> $source {
         $needed -= (%minimum{$source} // 0) * %provided{$letter}{$source};
      }
      %needed{$letter} = $needed if $needed > 0; # restore missing
   }


   # if we're left with needs, we have to do some searching, breadth first
   %minimum = complete-minimum(%minimum, %needed, %provided)
      if %needed.keys.elems > 0;

   return sum(values(%minimum));
}

sub letters-histogram ($word) {
   my %amount_for;
   %amount_for{$word.substr($_, 1)}++ for 0 ..^ $word.chars;
   return %amount_for;
}

sub complete-minimum (%minimum is copy, %needed is copy, %provided) {
   my @queue = {needed => %needed, minimum => %minimum},;
   while @queue {
      my $frame = @queue.shift;
      my $needed = $frame<needed>;
      my $minimum = $frame<minimum>;

      my %words = $needed.keys.map({ %provided{$_}.keys }).flat.map({ $_ => 1 });
      for %words.keys -> $source {
         my %nmin  = %$minimum;
         %nmin{$source}++;
         my %nneed = %$needed;
         for %nneed.keys -> $letter {
            %nneed{$letter} -= %provided{$letter}{$source} // 0;
            %nneed{$letter}:delete if %nneed{$letter} <= 0;
         }
         return %nmin if %nneed.keys.elems == 0;
         @queue.push: {needed => %nneed, minimum => %nmin};
      }
   }
   return ();
}
