#!/usr/bin/env raku
use v6;

sub MAIN (Int:D $n where * > 0 = 1) {
   # compute the "basic" Zeckendorf decomposition of $n
   my %lk = lekkerkerker($n);

   # compute a "reasonable" decomposition into possible non-overlapping
   # components
   my @components;
   for (0 .. %lk<indexes>.end).reverse -> $i {
      my $index = %lk<indexes>[$i];
      my $low_index = $i ?? %lk<indexes>[$i - 1] !! 0;
      my @alts = alternatives($index, $low_index);
      @components.push: @alts;
   }

   # compute all possible arrangements, reject those with overlaps and
   # print the others
   my $count = 0;
   nested_loops_recursive(
      @components,
      sub (*@stuff) {
         my %seen;
         my $sum = 0;
         for @stuff -> $constituent {
            for @$constituent -> $i {
               return if %seen{$i}++;
               my $fi = %lk<fibo>[$i];
               $sum += $fi;
            }
         }
         die "sum mismatch ($sum vs $n)\n" unless $n == $sum;
         ++$count;
      }
   );
   $count.put;
}

sub lekkerkerker (Int:D $n is copy) {
   my @fibo = 1, 2;
   push @fibo, @fibo[*-2] + @fibo[*-1] while @fibo[*-1] < $n;
   my $i = @fibo.end;
   my @indexes;
   while $n > 0 {
      --$i while @fibo[$i] > $n;
      @indexes.unshift: $i;
      $n -= @fibo[$i];
   }
   return (
      fibo => @fibo,
      indexes => @indexes,
   ).hash;
}

sub alternatives (Int:D $i is copy where * >= 0, Int:D $il where * >= 0) {
   my @item = $i;
   my @retval = [$i],;
   while $i > $il + 1 {
      @item.pop;
      @item.push: $i - 1;
      @item.push: $i - 2;
      @retval.push: [@item.List];
      $i -= 2;
   }
   return @retval;
}

sub nested_loops_recursive (@dims, &cb, @accumulator = []) {
   my $level = @accumulator.elems;
   if $level == @dims.elems { # fire callback!
      &cb(@accumulator);
      return;
   }
   for @dims[$level].List -> $item {
      @accumulator.push: $item;
      nested_loops_recursive(@dims, &cb, @accumulator);
      @accumulator.pop;
   }
   return;
}
