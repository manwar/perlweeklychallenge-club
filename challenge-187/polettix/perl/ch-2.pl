#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @result = magical_triplets(@ARGV);
say '(', join(', ', @result), ')';

sub magical_triplets (@n) {
   my $it = combinations_iterator(3, @n);
   my ($best, $best_score);
   while (my ($combination, $complement) = $it->()) {
      my $score = is_triangle($combination->@*) or next;
      ($best, $best_score) = ($combination, $score)
         if (! defined $best) || ($best_score < $score);
   }
   return reverse sort {$a <=> $b} ($best // [])->@*;
}

sub is_triangle ($A, $B, $C) {
   return 0 if
      $A >= $B + $C
      || $B >= $C + $A
      || $C >= $A + $B;
   return $A + $B + $C;
}

sub combinations_iterator ($k, @items) {
   my @indexes = (0 .. ($k - 1));
   my $n = @items;
   return sub {
      return unless @indexes;
      my (@combination, @remaining);
      my $j = 0;
      for my $i (0 .. ($n - 1)) {
         if ($j < $k && $i == $indexes[$j]) {
            push @combination, $items[$i];
            ++$j;
         }
         else {
            push @remaining, $items[$i];
         }
      }
      for my $incc (reverse(-1, 0 .. ($k - 1))) {
         if ($incc < 0) {
            @indexes = (); # finished!
         }
         elsif ((my $v = $indexes[$incc]) < $incc - $k + $n) {
            $indexes[$_] = ++$v for $incc .. ($k - 1);
            last;
         }
      }
      return (\@combination, \@remaining);
   }
}
