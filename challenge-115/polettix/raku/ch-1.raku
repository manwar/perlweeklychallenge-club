#!/usr/bin/env raku
use v6;

sub string-chain (@S is copy) {
   my $start = @S.shift;
   my $sf = $start.substr(0, 1);
   my $sl = $start.substr(*-1, 1);

   my %starting-with;
   for @S -> $s {
      %starting-with{$s.substr(0, 1)}.push([$s, 0]);
   }

   return unless %starting-with{$sl};
   my @chain = [%starting-with{$sl}, -1],;

   LINK:
   loop {
      my $top = @chain[*-1];
      if (my $i = $top[*-1]) < $top[0].elems - 1 {
         $top[0][$i][1] = 0 if $i >= 0;
         ++$i;
         ++$i while $i < $top[0].elems && $top[0][$i][1];

         $top[1] = $i;
         redo LINK if $i > $top[0].elems - 1;

         my $last_letter = $top[0][$i][0].substr(*-1,1);
         if (@chain.elems == @S.elems) {
            if ($last_letter eq $sf) {
               return [
                  $start,
                  @chain.map: -> $x {$x[0][$x[*-1]][0]}
               ];
            }
         }
         else {
            $top[0][$i][1] = 1;
            if my $sw = %starting-with{$last_letter} {
               @chain.push: [$sw, -1];
            }
            else {
               return if $last_letter ne $sf;
            }
         }
      }
      elsif (@chain.elems > 1) { @chain.pop }
      else                     { return     }
   }
}

sub MAIN (*@words is copy) {
   @words = < abc dea cd > unless @words.elems;
   my $chain = string-chain(@words);
   if ($chain) {
      say 1;
      $chain.join(' ').note;
   }
   else {
      say 0;
   }
}
