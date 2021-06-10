#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub decimal_string ($N, $D) {
   my $sign = ($N < 0) ^ ($D < 0) ? '-' : '';
   for ($N, $D) { $_ = -$_ if $_ < 0 }

   my $r = $N % $D;
   (my $i, $N) = (($N - $r) / $D, $r);
   $i = $sign . $i if $i || $N;
   return $i unless $N;

   # keep track of all quotes and rests we find in the integer divisions
   my (@ds, %position_of);
   while ($N) {
      if (exists $position_of{$N}) {
         push @ds, '(', splice(@ds, $position_of{$N}), ')';
         last;
      }
      $position_of{$N} = @ds;
      $N *= 10;
      $r = $N % $D;
      (my $i, $N) = (($N - $r) / $D, $r);
      push @ds, $i;
   }
   return $i . '.' . join '', @ds;
}

sub rational_pair ($x) {
   require Math::BigInt;
   my ($s, $i, $d) = $x =~ m{\A (-?) (\d*) (?:\. (.*))? \z}mxs;
   $d //= '';
   my ($ap, $p) = $d =~ m{\A (\d*) (?: \( (\d+) \) )?}mxs;
   my $pp = $i . $ap;
   $p //= '';
   my ($N, $D);
   if (my $lp = length $p) {
      $N = Math::BigInt->new($pp . $p) - Math::BigInt->new($pp);
      return (0, 1) unless $N;
      $D = Math::BigInt->new(('9' x length($p)) . ('0' x length($ap)));
   }
   else { # non-periodic
      $N = Math::BigInt->new($pp);
      $D = Math::BigInt->new('1' . ('0' x length($ap)));
   }
   my $g = $N ? gcd($N, $D) : 1;
   return ($s . ($N / $g), $D / $g);
}

sub gcd { my ($A, $B) = @_; ($A, $B) = ($B % $A, $A) while $A; return $B }

if (@ARGV == 2) {
   my ($num, $den) = @ARGV;
   my $dec = decimal_string($num, $den);
   say $dec;
   say {*STDERR} join '/', rational_pair($dec);
}
else {
   require Test::More;
   Test::More->import;
   for my $test (
      [0, 1, '0', 0, 1],
      [0, -1, '0', 0, 1],
      [0, 100, '0', 0, 1],
      [1, 2, '0.5', 1, 2],
      [3, 6, '0.5', 1, 2],
      [-1, 2, '-0.5', -1, 2],
      [1, -2, '-0.5', -1, 2],
      [11, -22, '-0.5', -1, 2],
      [14, 7, '2', 2, 1],
      [14, -7, '-2', -2, 1],
      [1, 3, '0.(3)', 1, 3],
      [2, 6, '0.(3)', 1, 3],
      [1, 7, '0.(142857)', 1, 7],
      [-3, -21, '0.(142857)', 1, 7],
      [1, 221, '0.(004524886877828054298642533936651583710407239819)', 1, 221 ],
   ) {
      my ($N, $D, $exp_dec, $exp_n, $exp_d) = $test->@*;
      my $got_dec = decimal_string($N, $D);
      Test::More::is($got_dec, $exp_dec, "decimal_string($N, $D) is $exp_dec");
      my ($got_n, $got_d) = rational_pair($exp_dec);
      Test::More::is($got_n, $exp_n, "numerator for $exp_dec is $exp_n");
      Test::More::is($got_d, $exp_d, "denominator for $exp_dec is $exp_d");
   }
   done_testing();
}
