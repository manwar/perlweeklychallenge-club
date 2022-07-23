#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util qw< reduce sum >;

say permutation2rank([qw< a b c d >]);
say permutation2rank([qw< 111 22 3 >]);
say join ' ', rank2permutation([qw< 0 1 2 >], 1)->@*;

sub permutation2rank ($permutation) {
   my $n = $permutation->@*;
   my @baseline = sort { $a cmp $b } $permutation->@*;
   my $factor = reduce { $a * $b } 1 .. $n;

   return sum map {
      my $target = $permutation->[$_];
      my $index = 0;
      ++$index while $baseline[$index] ne $target;
      splice @baseline, $index, 1;
      my $term = ($factor /= $n - $_) * $index;
   } 0 .. $n - 2;
}

sub rank2permutation ($baseline, $r) {
   my $n = $baseline->@*;
   my $factor = reduce { $a * $b } 1 .. $n - 1;
   return [
      map {
         my $index = int($r / $factor);
         $r %= $factor;
         $factor /= ($n - 1 - $_) if $factor > 1;
         splice $baseline->@*, $index, 1;
      } 0 .. $n - 1
   ];
}

__END__
