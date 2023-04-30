#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put collect-points(@args) }

sub collect-points (@numbers) {
   return 0 unless @numbers;
   my @slots = @numbers[0], 1;
   for 1 ..^ @numbers -> $i {
      if @numbers[$i - 1] == @numbers[$i] {
         @slots[*-1]++;
      }
      else {
         @slots.push: @numbers[$i], 1;
      }
   }
   return collect-points-wh(@slots);
}

sub collect-points-wh (@slots) {
   my $score = 0;

   loop {
      my %count-for;

      my $i = 0;
      while $i < @slots {
         (%count-for{@slots[$i]} //= 0)++;
         $i += 2;
      }

      my %is-single = %count-for.keys.grep({ %count-for{$_} == 1 })
         .map({ $_ => True });
      last unless %is-single.elems;

      $i = 0;
      while $i < @slots {
         if %is-single{@slots[$i]} {
            $score += @slots[$i + 1] ** 2;
            @slots = remove-slot($i, @slots);
         }
         else {
            $i += 2;
         }
      }
   }

   my $i = 0;
   my $best-sub-score = 0;
   while $i < @slots {
      my @sub-slots = remove-slot($i, @slots);
      my $sub-score = collect-points-wh(@sub-slots);
      $best-sub-score = $sub-score if $best-sub-score < $sub-score;
      $i += 2;
   }

   $score += $best-sub-score;
   return $score;
}

sub remove-slot ($i, @slots is copy) {
   @slots.splice($i, 2);
   if $i > 0 && $i < @slots && @slots[$i - 2] == @slots[$i] {
      @slots[$i - 1] += @slots[$i + 1];
      @slots.splice($i, 2);
   }
   return @slots;
}
