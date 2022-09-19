#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';

my $n = shift // 18;
my $m = shift // 2;
say simple_stringify_array(prime_partition($n, $m));

sub simple_stringify_array (@a) { return '(' . join(', ', @a), ')' }

sub prime_partition ($n, $m) {
   if ($m == 1) { return is_prime($n) ? $n : () }
   my $cit = combinations_iterator($m, primes_within(2, $n - 2));
   while (my ($c) = $cit->()) {
      return $c->@* if $n == sum $c->@*;
   }
   return;
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

sub primes_within ($min, $max) {
   my @retval = $min < 3 ? 2 : ();
   $min++ unless $min % 2;
   while ($min <= $max) {
      push @retval, $min if is_prime($min);
      $min += 2;
   }
   return @retval;
}

sub is_prime { # https://en.wikipedia.org/wiki/Primality_test
   return if $_[0] < 2;
   return 1 if $_[0] <= 3;
   return unless ($_[0] % 2) && ($_[0] % 3);
   for (my $i = 6 - 1; $i * $i <= $_[0]; $i += 6) {
      return unless ($_[0] % $i) && ($_[0] % ($i + 2));
   }
   return 1;
}
