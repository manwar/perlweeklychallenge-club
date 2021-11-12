#!/usr/bin/env raku
use v6;

sub split-number (Int:D $square) {
   my $root = $square.sqrt.Int;
   die "invalid input <$square>: not a square"
     unless $root * $root == $square;
   return 1 if $root ~~ /^ 9+ $/;
   my ($first, @digits) = $square.comb: /./;
   my $n-separators = @digits.elems;
   for 1 ..^ 2**$n-separators -> $i {
      my @split = $first,;
      my @separators = $i.base(2).comb: /./;
      @separators.unshift: 0 while @separators.elems < $n-separators;
      for 0 .. @separators.end -> $j {
         if @separators[$j] > 0 { @split.push: @digits[$j]   }
         else                   { @split[*-1] ~= @digits[$j] }
      }
      return 1 if @split.sum == $root;
   } ## end for my $i (1 .. 2**$n_separators...)
   return 0;
}

sub MAIN (*@args) {
   if @args { split-number(@args[0]).put }
   else {
      my @sequence = (1...Inf).map({$_**2}).grep({split-number($_) > 0});
      @sequence[0..^10].join(', ').put;
   }
}
