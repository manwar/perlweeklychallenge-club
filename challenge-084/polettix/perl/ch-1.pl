#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub reverse_integer ($N) {
   state $max_int = 0x7fffffff;
   my ($s, $x) = $N > 0
      ? ('', scalar reverse("$N"))
      : ('-', scalar reverse(''.(-$N)));
   $x =~ s{0+\z}{}mxs;
   my ($lx, $lm) = (length($x), length($max_int));
   return $s . $x
      if ($lx < $lm)
      || ($lx == $lm) && (substr($x, 0, 1) < 2);
   return 0
      if ($lx > $lm) # too long
      || substr($x, 0, 1) > 2; # highest digit too high
   # same length, first digit is 2...
   return $s
      ? ($x <= $max_int + 1 ? $s . $x : 0)
      : ($x <= $max_int     ?      $x : 0);
}

my $x = shift || -1234;
say reverse_integer($x);
